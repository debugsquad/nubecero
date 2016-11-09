import UIKit

class COnboardForm:CController
{
    private weak var viewForm:VOnboardForm!
    let model:MOnboardForm
    
    init(model:MOnboardForm)
    {
        self.model = model
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewForm:VOnboardForm = VOnboardForm(controller:self)
        self.viewForm = viewForm
        view = viewForm
    }
    
    //MARK: public
    
    func cancel()
    {
        parentController.dismiss()
    }
}
