import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    var controllers:[CController]
    private var statusBarStyle:UIStatusBarStyle
    
    init()
    {
        controllers = []
        statusBarStyle = UIStatusBarStyle.lightContent
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let login:CLogin = CLogin()
        over(controller:login, pop:false)
    }
    
    override func loadView()
    {
        let viewParent:VParent = VParent(parent:self)
        self.viewParent = viewParent
        view = viewParent
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return statusBarStyle
    }
    
    override var prefersStatusBarHidden:Bool
    {
        return false
    }
    
    //MARK: private
    
    private func mainController(controller:CController, underBar:Bool, pop:Bool)
    {
        addChildViewController(controller)
        controllers.last?.willMove(toParentViewController:nil)
        viewParent.over(controller:controller, underBar:underBar)
        
        if pop
        {
            let lastController:CController? = self.controllers.popLast()
            lastController?.view.removeFromSuperview()
            lastController?.removeFromParentViewController()
        }
        
        controllers.append(controller)
        controller.didMove(toParentViewController:self)
    }
    
    //MARK: public
    
    func statusBarLight()
    {
        statusBarStyle = UIStatusBarStyle.lightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func statusBarDefault()
    {
        statusBarStyle = UIStatusBarStyle.default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func push(controller:CController)
    {
        addChildViewController(controller)
        
        viewParent.push(controller:controller)
        {
            self.controllers.append(controller)
            controller.didMove(toParentViewController:self)
        }
    }
    
    func center(controller:CController, pop:Bool)
    {
        mainController(controller:controller, underBar:true, pop:pop)
    }
    
    func over(controller:CController, pop:Bool)
    {
        mainController(controller:controller, underBar:false, pop:pop)
    }
    
    func pop()
    {
        viewParent.pop()
        {
            let controller:CController = self.controllers.popLast()!
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }
    }
    
    func dismiss()
    {
        viewParent.dismiss()
        {
            let controller:CController = self.controllers.popLast()!
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }
    }
    
    func scrollLeft(controller:CController)
    {
        addChildViewController(controller)
        controllers.last?.willMove(toParentViewController:nil)
        
        viewParent.fromLeft(controller:controller)
        {
            let lastController:CController? = self.controllers.popLast()
            lastController?.view.removeFromSuperview()
            lastController?.removeFromParentViewController()
            self.controllers.append(controller)
            controller.didMove(toParentViewController:self)
        }
    }
    
    func scrollRight(controller:CController)
    {
        addChildViewController(controller)
        controllers.last?.willMove(toParentViewController:nil)
        
        viewParent.fromRight(controller:controller)
        {
            let lastController:CController? = self.controllers.popLast()
            lastController?.view.removeFromSuperview()
            lastController?.removeFromParentViewController()
            self.controllers.append(controller)
            controller.didMove(toParentViewController:self)
        }
    }
}
