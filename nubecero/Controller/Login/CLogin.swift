import UIKit
import UserNotifications
import Firebase
import FirebaseAuth

class CLogin:CController
{
    private weak var viewLogin:VLogin!
    private let kAskNotifications:TimeInterval = 4
    
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
        registerNotifications()
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
    
    private func registerNotifications()
    {
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAskNotifications)
        {
            if #available(iOS 10.0, *)
            {
                let authOptions:UNAuthorizationOptions = [
                    UNAuthorizationOptions.alert,
                    UNAuthorizationOptions.badge,
                    UNAuthorizationOptions.sound]
                
                UNUserNotificationCenter.current().requestAuthorization(options:authOptions)
                { (_, _) in
                }
            }
            else
            {
                let settings:UIUserNotificationSettings = UIUserNotificationSettings(
                    types:[
                        UIUserNotificationType.alert,
                        UIUserNotificationType.badge,
                        UIUserNotificationType.sound],
                    categories:nil)
                
                UIApplication.shared.registerUserNotificationSettings(settings)
            }
            
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}
