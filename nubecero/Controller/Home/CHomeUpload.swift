import UIKit
import Photos

class CHomeUpload:CController
{
    weak var viewUpload:VHomeUpload!
    weak var viewBar:VHomeUploadBar?
    let model:MHomeUpload
    private let kBarWidth:CGFloat = 150
    private let kAlertAfter:TimeInterval = 1
    
    init()
    {
        model = MHomeUpload()
        
        super.init(nibName:nil, bundle:nil)
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
                { [weak self] (status) in
                    
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
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        
        viewBar?.removeFromSuperview()
    }
    
    //MARK: private
    
    private func loadBar()
    {
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
            self?.loadBar()
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
            message:
            NSLocalizedString("CHomeUpload_uploadedMessage", comment:""),
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
        { (action) in
            
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
        guard
            
            let uploadItems:[MHomeUploadItem] = selectedItems()
            
        else
        {
            return
        }
        
        var deletableAssets:[PHAsset] = []
        
        for uploadItem:MHomeUploadItem in uploadItems
        {
            if uploadItem.status.finished
            {
                deletableAssets.append(uploadItem.asset)
            }
        }
        
        let deletableEnumeration:NSFastEnumeration = deletableAssets as NSFastEnumeration
        
        PHPhotoLibrary.shared().performChanges(
        {
            PHAssetChangeRequest.deleteAssets(deletableEnumeration)
        })
        { [weak self] (done, error) in
            
            if let errorStrong:Error = error
            {
                VAlert.message(message:errorStrong.localizedDescription)
            }
            else
            {
                self?.hideUploadedItems()
            }
        }
    }
    
    private func hideUploadedItems()
    {
        var newModelItems:[MHomeUploadItem] = []
        
        for currentItem:MHomeUploadItem in model.items
        {
            if !currentItem.status.finished
            {
                newModelItems.append(currentItem)
            }
        }
        
        model.items = newModelItems
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewUpload.collectionView.reloadData()
            self?.viewUpload.updateBar()
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
            
            let uploadItems:[MHomeUploadItem] = selectedItems()
        
        else
        {
            return
        }
        
        let controllerSync:CHomeUploadSync = CHomeUploadSync(
            uploadItems:uploadItems,
            controllerUpload:self)
        parentController.over(controller:controllerSync, pop:false)
    }
    
    func picturesUploaded()
    {
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAlertAfter)
        { [weak self] in
            
            self?.removePicturesAlert()
        }
    }
}
