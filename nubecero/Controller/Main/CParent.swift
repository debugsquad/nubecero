import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    var controllers:[CController]
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.lightContent
    
    init()
    {
        controllers = []
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
        over(controller:login)
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
    
    private func mainController(controller:CController, underBar:Bool)
    {
        addChildViewController(controller)
        controllers.last?.willMove(toParentViewController:nil)
        viewParent.over(controller:controller, underBar:underBar)
        
        let lastController:CController? = self.controllers.popLast()
        lastController?.view.removeFromSuperview()
        lastController?.removeFromParentViewController()
        
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
    
    func center(controller:CController)
    {
        mainController(controller:controller, underBar:true)
    }
    
    func over(controller:CController)
    {
        mainController(controller:controller, underBar:false)
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
