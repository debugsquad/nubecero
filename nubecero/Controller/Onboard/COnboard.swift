import UIKit

class COnboard:CController
{
    let model:MOnboard
    private weak var viewOnboard:VOnboard!
    private let kSuccessAfter:TimeInterval = 0.5
    
    init()
    {
        model = MOnboard()
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
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
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        parentController.statusBarLight()
    }
    
    //MARK: public
    
    func showForm(model:MOnboardForm)
    {
        let controllerForm:COnboardForm = COnboardForm(
            model:model,
            onboard:self)
        parentController.over(
            controller:controllerForm,
            pop:false,
            animate:true)
    }
    
    func authSuccess()
    {
        let successAfter:TimeInterval = kSuccessAfter
        viewOnboard.isUserInteractionEnabled = false
        parentController.dismiss()
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + successAfter)
        { [weak self] in
            
            let homeController:CHome = CHome(askAuth:true)
            self?.parentController.center(
                controller:homeController,
                pop:true,
                animate:true)
        }
    }
}
