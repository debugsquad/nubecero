import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    weak var controllerAuth:CAuth?
    private var controllers:[CController]
    private var statusBarStyle:UIStatusBarStyle
    
    init()
    {
        controllers = []
        statusBarStyle = UIStatusBarStyle.lightContent
        super.init(nibName:nil, bundle:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedUserBanned(sender:)),
            name:Notification.userBanned,
            object:nil)
        
        let login:CLogin = CLogin()
        over(controller:login, pop:false, animate:false)
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
    
    //MARK: notified
    
    func notifiedUserBanned(sender notification:Notification)
    {
        DispatchQueue.main.async
        {
            let controllerBanned:CBanned = CBanned()
            self.over(
                controller:controllerBanned,
                pop:true,
                animate:false)
        }
    }
    
    //MARK: private
    
    private func mainController(controller:CController, underBar:Bool, pop:Bool, animate:Bool)
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
        
        controllers.append(controller)
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:animate)
        
        currentController?.beginAppearanceTransition(false, animated:animate)
        
        viewParent.over(controller:controller, underBar:underBar, animate:animate)
        {
            controller.endAppearanceTransition()
            
            currentController?.view.removeFromSuperview()
            currentController?.removeFromParentViewController()
            currentController?.endAppearanceTransition()
        }
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
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:true)
        
        currentController.beginAppearanceTransition(false, animated:true)
        
        viewParent.push(controller:controller, currentController:currentController)
        {
            controller.endAppearanceTransition()
            currentController.endAppearanceTransition()
        }
    }
    
    func center(controller:CController, pop:Bool, animate:Bool)
    {
        mainController(controller:controller, underBar:true, pop:pop, animate:animate)
    }
    
    func over(controller:CController, pop:Bool, animate:Bool)
    {
        mainController(controller:controller, underBar:false, pop:pop, animate:animate)
    }
    
    func pop()
    {
        guard
            
            let currentController:CController = controllers.popLast(),
            let previousController:CController = controllers.last
        
        else
        {
            return
        }
        
        let popBar:Bool
        let countController:Int = controllers.count
        
        if countController > 1
        {
            popBar = false
        }
        else
        {
            popBar = true
        }
        
        previousController.beginAppearanceTransition(true, animated:true)
        currentController.beginAppearanceTransition(false, animated:true)
        
        viewParent.pop(
            currentController:currentController,
            previousController:previousController,
            popBar:popBar)
        {
            previousController.endAppearanceTransition()
            
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            currentController.endAppearanceTransition()
        }
    }
    
    func dismiss()
    {
        guard
            
            let currentController:CController = controllers.popLast(),
            let previousController:CController = controllers.last
        
        else
        {
            return
        }
        
        previousController.beginAppearanceTransition(true, animated:true)
        currentController.beginAppearanceTransition(false, animated:true)
        
        viewParent.dismiss(currentController:currentController)
        {
            previousController.endAppearanceTransition()
            
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            currentController.endAppearanceTransition()
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
        
        controllers.append(controller)
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:true)
        
        currentController.beginAppearanceTransition(false, animated:true)
        
        viewParent.fromLeft(controller:controller, currentController:currentController)
        {
            controller.endAppearanceTransition()
            
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            currentController.endAppearanceTransition()
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
        
        controllers.append(controller)
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:true)
        
        currentController.beginAppearanceTransition(false, animated:true)
        
        viewParent.fromRight(controller:controller, currentController:currentController)
        {
            controller.endAppearanceTransition()
            
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            currentController.endAppearanceTransition()
        }
    }
    
    func presentAuth()
    {
        if controllerAuth == nil
        {
            let controllerAuth:CAuth = CAuth()
            self.controllerAuth = controllerAuth
            over(controller:controllerAuth, pop:false, animate:false)
        }
    }
}
