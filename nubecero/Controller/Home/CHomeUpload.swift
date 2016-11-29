import UIKit
import Photos

class CHomeUpload:CController, CPhotosAlbumSelectionDelegate
{
    let model:MHomeUpload
    weak var viewBar:VHomeUploadBar?
    weak var album:MPhotosItem?
    private weak var viewUpload:VHomeUpload!
    private let kBarWidth:CGFloat = 150
    
    override init()
    {
        album = MPhotos.sharedInstance.defaultAlbum
        model = MHomeUpload()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewUpload:VHomeUpload = VHomeUpload(controller:self)
        self.viewUpload = viewUpload
        view = viewUpload
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CHomeUpload_title", comment:"")
        
        switch PHPhotoLibrary.authorizationStatus()
        {
            case PHAuthorizationStatus.denied,
                 PHAuthorizationStatus.restricted:
                
                authDenied()
                
                break
                
            case PHAuthorizationStatus.notDetermined:
                
                PHPhotoLibrary.requestAuthorization()
                { [weak self] (status:PHAuthorizationStatus) in
                    
                    if status == PHAuthorizationStatus.authorized
                    {
                        self?.authorized()
                    }
                    else
                    {
                        self?.authDenied()
                    }
                }
                
                break
                
            case PHAuthorizationStatus.authorized:
                
                authorized()
                
                break
        }
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        loadBar()
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        
        viewBar?.removeFromSuperview()
    }
    
    //MARK: private
    
    private func loadBar()
    {
        self.viewBar?.removeFromSuperview()
        
        let mainBar:VBar = parentController.viewParent.bar
        let viewBar:VHomeUploadBar = VHomeUploadBar(controller:self)
        self.viewBar = viewBar
        
        mainBar.addSubview(viewBar)
        
        let views:[String:UIView] = [
            "viewBar":viewBar]
        
        let metrics:[String:CGFloat] = [
            "barWidth":kBarWidth]
        
        mainBar.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[viewBar(barWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        mainBar.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[viewBar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        viewUpload.updateBar()
    }
    
    private func showError()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewUpload.showError()
        }
    }
    
    private func imagesLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewUpload.imagesLoaded()
        }
    }
    
    private func authDenied()
    {
        let errorMessage:String = NSLocalizedString("CHomeUpload_authDenied", comment:"")
        VAlert.message(message:errorMessage)
        showError()
    }
    
    private func errorLoadingCameraRoll()
    {
        let errorMessage:String = NSLocalizedString("CHomeUpload_noCameraRoll", comment:"")
        VAlert.message(message:errorMessage)
        showError()
    }
    
    private func authorized()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadCameraRoll()
        }
    }
    
    private func loadCameraRoll()
    {
        model.items = []
        
        let collectionResult:PHFetchResult = PHAssetCollection.fetchAssetCollections(
            with:PHAssetCollectionType.smartAlbum,
            subtype:PHAssetCollectionSubtype.smartAlbumUserLibrary,
            options:nil)
        
        guard
            
            let cameraRoll:PHAssetCollection = collectionResult.firstObject
            
        else
        {
            errorLoadingCameraRoll()
            
            return
        }
        
        let fetchOptions:PHFetchOptions = PHFetchOptions()
        let sortNewest:NSSortDescriptor = NSSortDescriptor(
            key:"creationDate",
            ascending:false)
        let predicateImages:NSPredicate = NSPredicate(
            format:"mediaType = %d",
            PHAssetMediaType.image.rawValue)
        fetchOptions.sortDescriptors = [sortNewest]
        fetchOptions.predicate = predicateImages
        
        let assetsResult:PHFetchResult = PHAsset.fetchAssets(
            in:cameraRoll,
            options:fetchOptions)
        let countAssets:Int = assetsResult.count
        
        for indexAsset:Int in 0 ..< countAssets
        {
            let asset:PHAsset = assetsResult[indexAsset]
            let uploadItem:MHomeUploadItem = MHomeUploadItem(asset:asset)
            
            model.items.append(uploadItem)
        }
        
        imagesLoaded()
    }
    
    private func removePicturesAlert()
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CHomeUpload_uploadedTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionDontRemove:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CHomeUpload_uploadedDontRemove", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionRemove:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CHomeUpload_uploadedRemove", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { (action:UIAlertAction) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.performRemovePictures()
            }
        }
        
        alert.addAction(actionRemove)
        alert.addAction(actionDontRemove)
        present(alert, animated:true, completion:nil)
    }
    
    private func performRemovePictures()
    {
        var deletableAssets:[PHAsset] = []
        
        for item:MHomeUploadItem in model.items
        {
            if item.status.finished
            {
                deletableAssets.append(item.asset)
            }
            else
            {
                guard
                
                    let _:MHomeUploadItemStatusClouded = item.status as? MHomeUploadItemStatusClouded
                
                else
                {                    
                    continue
                }
                
                deletableAssets.append(item.asset)
            }
        }
        
        let deletableEnumeration:NSFastEnumeration = deletableAssets as NSFastEnumeration
        
        PHPhotoLibrary.shared().performChanges(
        {
            PHAssetChangeRequest.deleteAssets(deletableEnumeration)
        })
        { [weak self] (done:Bool, error:Error?) in
            
            if let errorStrong:Error = error
            {
                VAlert.message(message:errorStrong.localizedDescription)
            }
            else
            {
                self?.loadCameraRoll()
            }
        }
    }
    
    private func selectedItems() -> [MHomeUploadItem]?
    {
        guard
            
            let selectedItems:[IndexPath] = viewUpload.collectionView.indexPathsForSelectedItems
            
        else
        {
            return nil
        }
        
        var uploadItems:[MHomeUploadItem] = []
        
        for indexSelected:IndexPath in selectedItems
        {
            let itemIndex:Int = indexSelected.item
            let uploadItem:MHomeUploadItem = model.items[itemIndex]
            uploadItems.append(uploadItem)
        }
        
        return uploadItems
    }
    
    //MARK: public
    
    func commitUpload()
    {
        guard
            
            var uploadItems:[MHomeUploadItem] = selectedItems()
        
        else
        {
            return
        }
        
        uploadItems.sort
        { (itemA:MHomeUploadItem, itemB:MHomeUploadItem) -> Bool in
            
            return itemA.creationDate > itemB.creationDate
        }
        
        let controllerSync:CHomeUploadSync = CHomeUploadSync(
            uploadItems:uploadItems,
            controllerUpload:self)
        parentController.over(
            controller:controllerSync,
            pop:false,
            animate:true)
    }
    
    func uploadFinished()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
                
            guard
            
                let autoDelete:Bool = MSession.sharedInstance.settings.current?.autoDelete
            
            else
            {
                return
            }
            
            if autoDelete
            {
                self?.performRemovePictures()
            }
        }
    }
    
    func clearAdded()
    {
        removePicturesAlert()
    }
    
    func changeAlbum()
    {   
        let albumSelect:CPhotosAlbumSelection = CPhotosAlbumSelection(
            currentAlbum:album,
            delegate:self)
        parentController.over(
            controller:albumSelect,
            pop:false,
            animate:true)
    }
    
    func selectAll(selection:Bool)
    {
        let collectionView:UICollectionView = viewUpload.collectionView
        let count:Int = model.items.count
        
        if selection
        {
            for indexItem:Int in 0 ..< count
            {
                let item:MHomeUploadItem = model.items[indexItem]
                
                guard
                
                    let _:MHomeUploadItemStatusNone = item.status as? MHomeUploadItemStatusNone
                
                else
                {
                    continue
                }
                
                item.statusWaiting()
                
                let indexPath:IndexPath = IndexPath(
                    item:indexItem,
                    section:0)
                collectionView.selectItem(
                    at:indexPath,
                    animated:false,
                    scrollPosition:UICollectionViewScrollPosition())
            }
        }
        else
        {
            for indexItem:Int in 0 ..< count
            {
                let item:MHomeUploadItem = model.items[indexItem]
                
                guard
                    
                    let _:MHomeUploadItemStatusWaiting = item.status as? MHomeUploadItemStatusWaiting
                    
                else
                {
                    continue
                }
                
                item.statusClear()
            }
            
            collectionView.reloadData()
        }
        
        viewUpload.updateBar()
    }
    
    //MARK: album selection delegate
    
    func albumSelected(album:MPhotosItem)
    {
        self.album = album
        viewUpload.header?.collectionView.reloadData()
    }
}
