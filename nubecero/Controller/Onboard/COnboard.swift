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
}
