import UIKit
import FirebaseAuth

class COnboardForm:CController
{
    private weak var viewForm:VOnboardForm!
    private weak var onboard:COnboard?
    private let kMinEmailLength:Int = 4
    let model:MOnboardForm
    weak var emailField:UITextField?
    weak var passwordField:UITextField?
    
    init(model:MOnboardForm, onboard:COnboard)
    {
        self.model = model
        self.onboard = onboard
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewForm:VOnboardForm = VOnboardForm(controller:self)
        self.viewForm = viewForm
        view = viewForm
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        emailField?.becomeFirstResponder()
    }
    
    //MARK: private
    
    private func errorForm(error:String)
    {
        VAlert.message(message:error)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewForm.hideLoading()
        }
    }
    
    private func signInSuccess(userId:MSession.UserId)
    {
        MSession.sharedInstance.user.loadUser(userId:userId)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.onboard?.authSuccess()
        }
    }
    
    private func registerSuccess(email:String, userId:MSession.UserId)
    {
        MSession.sharedInstance.user.createUser(
            email:email,
            userId:userId)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.onboard?.authSuccess()
        }
    }
    
    private func rememberCredentials(credentials:MOnboardFormCredentials)
    {
        guard
        
            let remember:Bool = MSession.sharedInstance.settings.current?.rememberMe
        
        else
        {
            return
        }
        
        if remember
        {
            MSession.sharedInstance.settings.current?.lastEmail = credentials.email
            MSession.sharedInstance.settings.current?.lastPassword = credentials.password
        }
        else
        {
            MSession.sharedInstance.settings.current?.lastEmail = nil
            MSession.sharedInstance.settings.current?.lastPassword = nil
        }
        
        DManager.sharedInstance.save()
    }
    
    private func authenticateRegister(credentials:MOnboardFormCredentials)
    {
        FMain.sharedInstance.analytics?.sessionTryRegister()
        
        FIRAuth.auth()?.createUser(
            withEmail:credentials.email,
            password:credentials.password)
        { [weak self] (user:FIRUser?, error:Error?) in
            
            guard
                
                let firUser:FIRUser = user
                
            else
            {
                let errorString:String
                
                if let error:Error = error
                {
                    errorString = error.localizedDescription
                }
                else
                {
                    errorString = NSLocalizedString("COnboardForm_errorUnknown", comment:"")
                }
                
                self?.errorForm(error:errorString)
                
                return
            }
            
            FMain.sharedInstance.analytics?.sessionRegister()
            let email:String = credentials.email
            let userId:MSession.UserId = firUser.uid
            
            self?.registerSuccess(
                email:email,
                userId:userId)
        }
    }
    
    private func authenticateSignin(credentials:MOnboardFormCredentials)
    {
        FIRAuth.auth()?.signIn(
            withEmail:credentials.email,
            password:credentials.password)
        { [weak self] (user, error) in
            
            guard
                
                let firUser:FIRUser = user
                
            else
            {
                let errorString:String
                
                if let error:Error = error
                {
                    errorString = error.localizedDescription
                }
                else
                {
                    errorString = NSLocalizedString("COnboardForm_errorUnknown", comment:"")
                }
                
                self?.errorForm(error:errorString)
                
                return
            }
            
            FMain.sharedInstance.analytics?.sessionSignin()
            let userId:MSession.UserId = firUser.uid
            
            self?.signInSuccess(userId:userId)
        }
    }
    
    //MARK: public
    
    func cancel()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        parentController.dismiss()
    }
    
    func send()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        viewForm.showLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in

            self?.model.createCredentials
            { [weak self] (credentials, errorString) in
                
                guard
                
                    let strongCredentials:MOnboardFormCredentials = credentials,
                    let method:MOnboardForm.Method = self?.model.method
                
                else
                {
                    if let error:String = errorString
                    {
                        self?.errorForm(error:error)
                    }
                    
                    return
                }
                
                self?.rememberCredentials(credentials:strongCredentials)
                
                switch method
                {
                    case MOnboardForm.Method.Register:
                    
                        self?.authenticateRegister(
                            credentials:strongCredentials)
                        
                        break
                    
                    case MOnboardForm.Method.Signin:
                    
                        self?.authenticateSignin(
                            credentials:strongCredentials)
                        
                        break
                }
            }
        }
    }
    
    func forgotPassword()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("COnboardForm_forgotTitle", comment:""),
            message:
            NSLocalizedString("COnboardForm_forgotSubtitle", comment:""),
            preferredStyle:UIAlertControllerStyle.alert)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("COnboardForm_forgotCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionSend:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("COnboardForm_forgotSend", comment:""),
            style:
            UIAlertActionStyle.default)
        { [weak self] (action) in
            
            guard
                
                let email:String = alert.textFields?.first?.text,
                let minEmailLength:Int = self?.kMinEmailLength
            
            else
            {
                return
            }
            
            if email.characters.count > minEmailLength
            {
                FIRAuth.auth()?.sendPasswordReset(withEmail:email)
                { (error:Error?) in
                    
                    let message:String
                    
                    if let error:Error = error
                    {
                        message = error.localizedDescription
                    }
                    else
                    {
                        message = NSLocalizedString("COnboardForm_forgotSuccess", comment:"")
                    }
                    
                    VAlert.message(message:message)
                }
            }
            else
            {
                let message:String = NSLocalizedString("COnboardForm_forgotInvalidEmail", comment:"")
                VAlert.message(message:message)
            }
        }
        
        alert.addTextField
            { (textfield:UITextField) in
            
            textfield.placeholder = NSLocalizedString("COnboardForm_forgotPlaceholder", comment:"")
            textfield.keyboardType = UIKeyboardType.emailAddress
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionSend)
        
        present(alert, animated:true, completion:nil)
    }
}
