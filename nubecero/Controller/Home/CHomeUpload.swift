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
    }
    
    private func authorized()
    {
        print("start loading pictures")
    }
}
