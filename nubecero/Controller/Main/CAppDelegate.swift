import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate
{
    var window:UIWindow?
    private weak var parent:CParent!

    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey:Any]?) -> Bool
    {
        FMain.sharedInstance.load()
        FBSDKApplicationDelegate.sharedInstance().application(
            application,
            didFinishLaunchingWithOptions:launchOptions)
        
        let window:UIWindow = UIWindow(frame:UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        
        let parent:CParent = CParent()
        self.parent = parent
        
        window.rootViewController = parent
        self.window = window
        
        return true
    }
    
    func application(_ app:UIApplication, open url:URL, options:[UIApplicationOpenURLOptionsKey:Any] = [:]) -> Bool
    {
        let handled:Bool = FBSDKApplicationDelegate.sharedInstance().application(
            app,
            open:url,
            options:options)
        
        return handled
    }
    
    func applicationDidEnterBackground(_ application:UIApplication)
    {
        guard
            
            let askAuth:Bool = MSession.sharedInstance.settings?.security
            
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
}
