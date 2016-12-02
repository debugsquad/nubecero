import UIKit
import Firebase

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate
{
    var window:UIWindow?

    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey:Any]?) -> Bool
    {
        FMain.sharedInstance.load()
        
        let window:UIWindow = UIWindow(frame:UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        
        let parent:CParent = CParent()
        window.rootViewController = parent
        self.window = window
        
        return true
    }
    
    func applicationDidEnterBackground(_ application:UIApplication)
    {
        guard
            
            let askAuth:Bool = MSession.sharedInstance.settings.current?.security
            
        else
        {
            return
        }
        
        if askAuth
        {
            parent.presentAuth()
        }
    }
    
    func applicationWillEnterForeground(_ application:UIApplication)
    {
        parent.controllerAuth?.askAuth()
    }
    
    func application(_ application:UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken:Data)
    {
        FIRInstanceID.instanceID().setAPNSToken(
            deviceToken,
            type:FIRInstanceIDAPNSTokenType.unknown)
    }
}
