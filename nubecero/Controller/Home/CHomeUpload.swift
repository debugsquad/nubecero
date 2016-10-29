import UIKit
import Photos

class CHomeUpload:CController
{
    weak var viewUpload:VHomeUpload!
    
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
    
    private func authDenied()
    {
        let errorMessage:String = NSLocalizedString("CHomeUpload_authDenied", comment:"")
        VAlert.message(message:errorMessage)
        
        viewUpload.showError()
    }
    
    private func errorLoadingCameraRoll()
    {
        let errorMessage:String = NSLocalizedString("CHomeUpload_noCameraRoll", comment:"")
        VAlert.message(message:errorMessage)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewUpload.showError()
        }
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
        let fetchOptions:PHFetchOptions = PHFetchOptions()
        let sortNewest:NSSortDescriptor = NSSortDescriptor(key:"creationDate", ascending:false)
        let predicateImages:NSPredicate = NSPredicate(format:"mediaType = %d", PHAssetMediaType.image.rawValue)
        //        fetchOptions.sortDescriptors = [sortNewest]
        //        fetchOptions.predicate = predicateImages
        
        let fetchResult:PHFetchResult = PHAssetCollection.fetchAssetCollections(with:PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary, options:nil)
        
        guard
            
            let cameraRoll:PHAssetCollection = fetchResult[2]
            
        else
        {
            errorLoadingCameraRoll()
            
            return
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
