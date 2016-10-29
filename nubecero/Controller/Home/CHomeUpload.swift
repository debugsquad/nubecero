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
        PHPhotoLibrary.
    }
}
