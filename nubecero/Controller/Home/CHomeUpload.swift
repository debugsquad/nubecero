import UIKit
import Photos

class CHomeUpload:CController
{
    weak var viewUpload:VHomeUpload!
    let model:MHomeUpload
    
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
    
    //MARK: private
    
    private func showError()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewUpload.showError()
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
        let sortNewest:NSSortDescriptor = NSSortDescriptor(key:"creationDate", ascending:false)
        let predicateImages:NSPredicate = NSPredicate(format:"mediaType = %d", PHAssetMediaType.image.rawValue)
        fetchOptions.sortDescriptors = [sortNewest]
        fetchOptions.predicate = predicateImages
        
        let assetsResult:PHFetchResult = PHAsset.fetchAssets(
            in:cameraRoll,
            options:fetchOptions)
        let countAssets:Int = assetsResult.count
        
        for indexAsset:Int in 0 ..< countAssets
        {
            let asset:PHAsset = assetsResult[indexAsset]
        }
        
        /*
        let countResults:Int = fetchResult.count
        fetchResult.fi
        
        
        for indexResult:Int in 0 ..< countResults
        {
            PHAsset.media
            
            let collectionResult:PHCollection = fetchResult[indexResult]
            print("-----")
            print(collectionResult.localizedTitle)
        }*/
    }
}
