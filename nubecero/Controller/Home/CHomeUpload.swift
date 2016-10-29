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
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        switch PHPhotoLibrary.authorizationStatus()
        {
            case PHAuthorizationStatus.denied,
                 PHAuthorizationStatus.restricted,
                 PHAuthorizationStatus.notDetermined:
            
                let errorMessage:String = NSLocalizedString("CHomeUpload_authDenied", comment:"")
                VAlert.message(message:errorMessage)
                
                break
            
            case PHAuthorizationStatus.authorized:
                
                break
        }
    }
}
