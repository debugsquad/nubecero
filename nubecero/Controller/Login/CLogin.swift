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
        
        if let user = FIRAuth.auth()?.currentUser {
            
            print("user signed")
            
        } else {
            
            print("user not signed")
        }
    }
    
    //MARK: login button delegate
    
    func loginButton(_ loginButton:FBSDKLoginButton!, didCompleteWith result:FBSDKLoginManagerLoginResult!, error:Error!)
    {
        if let error:Error = error
        {
            print("facebook error")
            print(error.localizedDescription)
        }
        else
        {
            let firebaseCredential:FIRAuthCredential = FIRFacebookAuthProvider.credential(
                withAccessToken:FBSDKAccessToken.current().tokenString)
            FIRAuth.auth()?.signIn(
                with:firebaseCredential)
            { [weak self] (user, error) in
                
                print("firebase signed")
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton:FBSDKLoginButton!)
    {
    }
}
