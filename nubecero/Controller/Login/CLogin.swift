import UIKit
import FirebaseAuth

class CLogin:CController
{
    private weak var viewLogin:VLogin!
    private let fetchCredentials:Bool
    var model:MLogin
    
    init(fetchCredentials:Bool)
    {
        model = MLogin.None()
        self.fetchCredentials = fetchCredentials
        
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
        
        if fetchCredentials
        {
            NotificationCenter.default.addObserver(
                self,
                selector:#selector(notifiedSettingsLoaded(sender:)),
                name:Notification.settingsLoaded,
                object:nil)
            
            MSession.sharedInstance.loadSettings()
        }
        else
        {
            userNotLogged()
        }
    }
    
    //MARK: notified
    
    func notifiedSettingsLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        
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
    
    func userNotLogged()
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
            viewLogin.hideLoading()
            
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
            viewLogin.hideLoading()
            
            return
        }
        
        guard
            
            let email:String = model.email
            
        else
        {
            let message:String = NSLocalizedString("CLogin_invalidEmail", comment:"")
            VAlert.message(message:message)
            viewLogin.hideLoading()
            
            return
        }
        
        guard
            
            let password:String = model.password
            
        else
        {
            let message:String = NSLocalizedString("CLogin_invalidPassword", comment:"")
            VAlert.message(message:message)
            viewLogin.hideLoading()
            
            return
        }
        
        if email.characters.isEmpty
        {
            let message:String = NSLocalizedString("CLogin_invalidEmail", comment:"")
            VAlert.message(message:message)
            viewLogin.hideLoading()
            
            return
        }
        
        if password.characters.isEmpty
        {
            let message:String = NSLocalizedString("CLogin_invalidPassword", comment:"")
            VAlert.message(message:message)
            viewLogin.hideLoading()
            
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
        FMain.sharedInstance.analytics?.trySignin()
        
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
                self?.viewLogin.hideLoading()
                
                return
            }
            
            FMain.sharedInstance.analytics?.signin()
            
            self?.userLogged()
        }
    }
    
    private func tryRegister(email:String, password:String)
    {
        FMain.sharedInstance.analytics?.tryRegister()
        
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
                self?.viewLogin.hideLoading()
                
                return
            }
            
            FMain.sharedInstance.analytics?.register()
            
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
        viewLogin.showLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncSendLogin()
        }
    }
}
