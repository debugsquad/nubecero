import UIKit

class COnboardForm:CController
{
    private weak var viewForm:VOnboardForm!
    
    override func loadView()
    {
        let viewForm:VOnboardForm = VOnboardForm(controller:self)
        self.viewForm = viewForm
        view = viewForm
    }
}
