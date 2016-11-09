import UIKit

class COnboardForm:CController
{
    private weak var viewForm:VOnboardForm!
    let model:MOnboardForm
    weak var emailField:UITextField?
    weak var passwordField:UITextField?
    
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
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        emailField?.becomeFirstResponder()
    }
    
    //MARK: public
    
    func cancel()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        parentController.dismiss()
    }
    
    func send()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        viewForm.showLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in

        }
    }
}
