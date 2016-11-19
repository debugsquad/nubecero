import UIKit
import Firebase
import FirebaseAuth

class CLogin:CController
{
    private weak var viewLogin:VLogin!
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView()
    {
        let viewLogin:VLogin = VLogin(controller:self)
        self.viewLogin = viewLogin
        view = viewLogin
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedSettingsLoaded(sender:)),
            name:Notification.settingsLoaded,
            object:nil)
        
        MSession.sharedInstance.settings.loadSettings()
    }
    
    //MARK: notified
    
    func notifiedSettingsLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
                
                let userId:MSession.UserId = FIRAuth.auth()?.currentUser?.uid
                
            else
            {
                self?.userNotLogged()
                
                return
            }
            
            MSession.sharedInstance.user.loadUser(userId:userId)
            
            DispatchQueue.main.async
            { [weak self] in
                
                let homeController:CHome = CHome(askAuth:true)
                self?.parentController.center(
                    controller:homeController,
                    pop:true,
                    animate:true)
            }
        }
    }
    
    //MARK: private
    
    private func userNotLogged()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            let controllerOnboard:COnboard = COnboard()
            self?.parentController.over(
                controller:controllerOnboard,
                pop:true,
                animate:true)
        }
    }
}
