import UIKit

class CHomeUploadSync:CController
{
    weak var viewSync:VHomeUploadSync!
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.statusBarDefault()
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        parentController.statusBarLight()
    }
    
    override func loadView()
    {
        let viewSync:VHomeUploadSync = VHomeUploadSync(controller:self)
        self.viewSync = viewSync
        view = viewSync
    }
}
