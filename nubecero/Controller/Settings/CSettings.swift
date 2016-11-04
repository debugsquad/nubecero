import UIKit
import FBSDKLoginKit
import FirebaseAuth

class CSettings:CController, FBSDKLoginButtonDelegate
{
    private weak var viewSettings:VSettings!
    let model:MSettings
    
    init()
    {
        model = MSettings()
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewSettings:VSettings = VSettings(controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
    
    //MARK: public
    
    func logOut()
    {
        let manager:FBSDKLoginManager = FBSDKLoginManager()
        manager.logOut()
        
        do
        {
            try FIRAuth.auth()?.signOut()
        }
        catch
        {
            
        }
        
        let controllerLogin:CLogin = CLogin()
        parentController.over(controller:controllerLogin, pop:true, animate:false)
    }
    
    //MARK: login delegate
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("more shit")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        print("shit")
    }
}
