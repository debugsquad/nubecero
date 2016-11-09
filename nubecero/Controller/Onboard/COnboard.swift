import UIKit

class COnboard:CController
{
    private weak var viewOnboard:VOnboard!
    let model:MOnboard
    
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
    
    override func viewDidDisappear(_ animated:Bool)
    {
        super.viewDidDisappear(animated)
        parentController.statusBarLight()
    }
    
    //MARK: public
    
    func showForm(model:MOnboardForm)
    {
        let controllerForm:COnboardForm = COnboardForm(model:model)
        parentController.over(
            controller:controllerForm,
            pop:false,
            animate:true)
    }
}
