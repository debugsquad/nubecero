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
    
    func pop(popBar:Bool)
    {
        guard
            
            let currentController:CController = controllers.popLast(),
            let previousController:CController = controllers.popLast()
        
        else
        {
            return
        }
        
        currentController.willMove(toParentViewController:nil)
        currentController.beginAppearanceTransition(false, animated:true)
        
        previousController.willMove(toParentViewController:self)
        previousController.beginAppearanceTransition(true, animated:true)
        
        viewParent.pop(
            currentController:currentController,
            previousController:previousController,
            popBar:popBar)
        {
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            currentController.didMove(toParentViewController:nil)
            currentController.endAppearanceTransition()
            
            previousController.didMove(toParentViewController:self)
            previousController.endAppearanceTransition()
        }
    }
    
    func dismiss()
    {
        guard
            
            let currentController:CController = controllers.popLast(),
            let previousController:CController = controllers.popLast()
        
        else
        {
            return
        }
        
        currentController.willMove(toParentViewController:nil)
        currentController.beginAppearanceTransition(false, animated:true)
        
        previousController.willMove(toParentViewController:self)
        previousController.beginAppearanceTransition(true, animated:true)
        
        viewParent.dismiss(currentController:currentController)
        {
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            currentController.didMove(toParentViewController:nil)
            currentController.endAppearanceTransition()
            
            previousController.didMove(toParentViewController:self)
            previousController.endAppearanceTransition()
        }
    }
    
    func scrollLeft(controller:CController)
    {
        guard
            
            let currentController:CController = controllers.popLast()
        
        else
        {
            return
        }
        
        currentController.willMove(toParentViewController:nil)
        currentController.beginAppearanceTransition(false, animated:true)
        
        controllers.append(controller)
        controller.willMove(toParentViewController:self)
        controller.beginAppearanceTransition(true, animated:true)
        addChildViewController(controller)
        
        viewParent.fromLeft(controller:controller, currentController:currentController)
        {
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            currentController.didMove(toParentViewController:nil)
            currentController.endAppearanceTransition()
            
            controller.didMove(toParentViewController:self)
            controller.endAppearanceTransition()
        }
    }
    
    func scrollRight(controller:CController)
    {
        guard
            
            let currentController:CController = controllers.popLast()
            
            else
        {
            return
        }
        
        currentController.willMove(toParentViewController:nil)
        currentController.beginAppearanceTransition(false, animated:true)
        
        controllers.append(controller)
        controller.willMove(toParentViewController:self)
        controller.beginAppearanceTransition(true, animated:true)
        addChildViewController(controller)
        
        viewParent.fromRight(controller:controller, currentController:currentController)
        {
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            currentController.didMove(toParentViewController:nil)
            currentController.endAppearanceTransition()
            
            controller.didMove(toParentViewController:self)
            controller.endAppearanceTransition()
        }
    }
}
