import UIKit
import Photos

class CHomeUpload:CController
{
    weak var viewUpload:VHomeUpload!
    weak var viewBar:VHomeUploadBar?
    let model:MHomeUpload
    private let kBarWidth:CGFloat = 150
    
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
    
    //MARK: public
    
    func commitUpload(uploadItems:[MHomeUploadItem])
    {
        let controllerSync:CHomeUploadSync = CHomeUploadSync(uploadItems:uploadItems)
        parentController.over(controller:controllerSync, pop:false)
    }
}
