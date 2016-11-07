import UIKit
import FirebaseAuth

class CLogin:CController
{
    private weak var viewLogin:VLogin!
    var model:MLogin
    
    init()
    {
        model = MLogin.None()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
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
        
        MSession.sharedInstance.loadSettings()
    }
    
    //MARK: notified
    
    func notifiedSettingsLoaded(sender notification:Notification)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
                
                let _:FIRUser = FIRAuth.auth()?.currentUser
                
            else
            {
                self?.userNotLogged()
                
                return
            }
            
            self?.userLogged()
        }
    }
    
    //MARK: private
    
    private func userNotLogged()
    {
        model = MLogin.Register()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewLogin.refresh()
        }
    }
    
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
            
            let homeController:CHome = CHome(askAuth:true)
            self?.parentController.center(
                controller:homeController,
                pop:true,
                animate:true)
        }
    }
    
    private func asyncSendLogin()
    {
        guard
        
            let modeType:MLoginMode.ModeType = model.mode?.modeType
        
        else
        {
            return
        }
        
        guard
            
            let email:String = model.email
            
        else
        {
            let message:String = NSLocalizedString("CLogin_invalidEmail", comment:"")
            VAlert.message(message:message)
            
            return
        }
        
        guard
            
            let password:String = model.password
            
        else
        {
            let message:String = NSLocalizedString("CLogin_invalidPassword", comment:"")
            VAlert.message(message:message)
            
            return
        }
        
        if email.characters.count < 1
        {
            let message:String = NSLocalizedString("CLogin_invalidEmail", comment:"")
            VAlert.message(message:message)
            
            return
        }
        
        if password.characters.count < 1
        {
            let message:String = NSLocalizedString("CLogin_invalidPassword", comment:"")
            VAlert.message(message:message)
            
            return
        }
        
        switch modeType
        {
            case MLoginMode.ModeType.register:
            
                tryRegister(email:email, password:password)
                
                break
            
            case MLoginMode.ModeType.signin:
            
                trySignin(email:email, password:password)
                
                break
        }
    }
    
    private func trySignin(email:String, password:String)
    {
        FIRAuth.auth()?.signIn(
            withEmail:email,
            password:password)
        { [weak self] (user, error) in
            
            guard
                
                let _:FIRUser = user
                
            else
            {
                let errorString:String
                
                if let error:Error = error
                {
                    errorString = error.localizedDescription
                }
                else
                {
                    errorString = NSLocalizedString("CLogin_errorUnknown", comment:"")
                }
                
                VAlert.message(message:errorString)
                
                return
            }
            
            self?.userLogged()
        }
    }
    
    private func tryRegister(email:String, password:String)
    {
        FIRAuth.auth()?.createUser(
            withEmail:email,
            password:password)
        { [weak self] (user, error) in
            
            guard
                
                let _:FIRUser = user
                
            else
            {
                let errorString:String
                
                if let error:Error = error
                {
                    errorString = error.localizedDescription
                }
                else
                {
                    errorString = NSLocalizedString("CLogin_errorUnknown", comment:"")
                }
                
                VAlert.message(message:errorString)
                
                return
            }
            
            self?.userLogged()
        }
    }
    
    //MARK: public
    
    func changeMode(modeType:MLoginMode.ModeType)
    {
        model = MLogin.WithMode(modeType:modeType)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewLogin.refresh()
        }
    }
    
    func sendLogin()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncSendLogin()
        }
    }
    
    /*
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
    }*/
}
