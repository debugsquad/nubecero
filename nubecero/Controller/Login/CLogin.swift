import UIKit
import FBSDKLoginKit
import FirebaseAuth

class CLogin:CController, FBSDKLoginButtonDelegate
{
    weak var viewLogin:VLogin!
    
    override func loadView()
    {
        let viewLogin:VLogin = VLogin(controller:self)
        self.viewLogin = viewLogin
        view = viewLogin
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        guard
            
            let _:FIRUser = FIRAuth.auth()?.currentUser
            
        else
        {
            return
        }
        
        userLogged()
    }
    
    //MARK: private
    
    private func userLogged()
    {
        guard
            
            let userId:String = FIRAuth.auth()?.currentUser?.uid
        
        else
        {
            return
        }
        
        MSession.sharedInstance.loadUser(userId:userId)
        
        DispatchQueue.main.async
        { [weak self] in
            
            let homeController:CHome = CHome()
            self?.parentController.center(
                controller:homeController,
                pop:true,
                animate:true)
        }
    }
    
    private func loginError(error:String)
    {
        VAlert.message(message:error)
    }
    
    //MARK: login button delegate
    
    func loginButton(_ loginButton:FBSDKLoginButton!, didCompleteWith result:FBSDKLoginManagerLoginResult!, error:Error!)
    {
        if let error:Error = error
        {
            loginError(error:error.localizedDescription)
        }
        else
        {
            guard
                
                let accessToken:FBSDKAccessToken = FBSDKAccessToken.current(),
                let tokenString:String = accessToken.tokenString
            
            else
            {
                let errorString:String = NSLocalizedString("CLogin_errorUnknown", comment:"")
                loginError(error:errorString)
                
                return
            }
            
            let firebaseCredential:FIRAuthCredential = FIRFacebookAuthProvider.credential(
                withAccessToken:tokenString)
            
            FIRAuth.auth()?.signIn(
                with:firebaseCredential)
            { [weak self] (user, error) in
                
                guard
                
                    let _:FIRUser = user
                
                else
                {
                    if let error:Error = error
                    {
                        self?.loginError(error:error.localizedDescription)
                    }
                    
                    return
                }
                
                self?.userLogged()
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton:FBSDKLoginButton!)
    {
        loginError(error:NSLocalizedString("CLogin_logOut", comment:""))
    }
}
