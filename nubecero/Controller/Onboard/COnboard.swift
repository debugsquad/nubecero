import UIKit

class COnboard:CController
{
    weak var viewOnboard:VOnboard!
    
    override func loadView()
    {
        let viewOnboard:VOnboard = VOnboard(controller:self)
        self.viewOnboard = viewOnboard
        view = viewOnboard
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.statusBarDefault()
    }
    
    override func viewDidDisappear(_ animated:Bool)
    {
        super.viewDidDisappear(animated)
        parentController.statusBarLight()
    }
}
