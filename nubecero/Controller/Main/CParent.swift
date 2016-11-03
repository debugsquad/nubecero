import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    private var controllers:[CController]
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
        let currentController:CController?
        
        if pop
        {
            currentController = controllers.popLast()
        }
        else
        {
            currentController = nil
        }
        
        currentController?.willMove(toParentViewController:nil)
        currentController?.beginAppearanceTransition(false, animated:true)
        
        controllers.append(controller)
        controller.willMove(toParentViewController:self)
        controller.beginAppearanceTransition(true, animated:true)
        addChildViewController(controller)
        
        viewParent.over(controller:controller, underBar:underBar)
        
        currentController?.view.removeFromSuperview()
        currentController?.removeFromParentViewController()
        currentController?.didMove(toParentViewController:nil)
        currentController?.endAppearanceTransition()
        
        controller.didMove(toParentViewController:self)
        controller.endAppearanceTransition()
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
        guard
            
            let currentController:CController = controllers.last
        
        else
        {
            return
        }
        
        controllers.append(controller)
        currentController.willMove(toParentViewController:nil)
        currentController.beginAppearanceTransition(false, animated:true)
        
        controller.willMove(toParentViewController:self)
        controller.beginAppearanceTransition(true, animated:true)
        addChildViewController(controller)
        
        viewParent.push(controller:controller, currentController:currentController)
        {
            currentController.didMove(toParentViewController:nil)
            currentController.endAppearanceTransition()
            
            controller.didMove(toParentViewController:self)
            controller.endAppearanceTransition()
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
        viewParent.pop
        {
            let controller:CController = self.controllers.popLast()!
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
            let current:CController = self.controllers.last!
            current.didMove(toParentViewController:self)
            current.beginAppearanceTransition(true, animated:true)
            current.endAppearanceTransition()
        }
    }
    
    func dismiss()
    {
        viewParent.dismiss
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
        let currentController:CController? = controllers.last
        
        addChildViewController(controller)
        currentController?.willMove(toParentViewController:nil)
        currentController?.beginAppearanceTransition(false, animated:true)
        
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
