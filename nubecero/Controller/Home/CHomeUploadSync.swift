import UIKit

class CHomeUploadSync:CController
{
    weak var viewSync:VHomeUploadSync!
    
    override func loadView()
    {
        let viewSync:VHomeUploadSync = VHomeUploadSync(controller:self)
        self.viewSync = viewSync
        view = viewSync
    }
}
