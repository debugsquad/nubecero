import UIKit
import FirebaseAuth

class COnboardForm:CController
{
    private weak var viewForm:VOnboardForm!
    private weak var onboard:COnboard?
    let model:MOnboardForm
    weak var emailField:UITextField?
    weak var passwordField:UITextField?
    
    init(model:MOnboardForm, onboard:COnboard)
    {
        self.model = model
        self.onboard = onboard
        super.init(nibName:nil, bundle:nil)
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
    
    private func authSuccess(userId:String)
    {
        MSession.sharedInstance.loadUser(userId:userId)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.onboard?.authSuccess()
        }
    }
    
    private func rememberCredentials(credentials:MOnboardFormCredentials)
    {
        guard
        
            let remember:Bool = MSession.sharedInstance.settings?.rememberMe
        
        else
        {
            return
        }
        
        if remember
        {
            MSession.sharedInstance.settings?.lastEmail = credentials.email
            MSession.sharedInstance.settings?.lastPassword = credentials.password
        }
        else
        {
            MSession.sharedInstance.settings?.lastEmail = nil
            MSession.sharedInstance.settings?.lastPassword = nil
        }
        
        DManager.sharedInstance.save()
    }
    
    private func authenticateRegister(credentials:MOnboardFormCredentials)
    {
        FMain.sharedInstance.analytics?.tryRegister()
        
        FIRAuth.auth()?.createUser(
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
            
            FMain.sharedInstance.analytics?.register()
            self?.authSuccess(userId:firUser.uid)
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
            
            FMain.sharedInstance.analytics?.signin()
            self?.authSuccess(userId:firUser.uid)
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
            NSLocalizedString("Enter your Email address", comment:""),
            message:
            NSLocalizedString("Your password will be restarted", comment:""),
            preferredStyle:UIAlertControllerStyle.alert)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("Cancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionRestart:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("Restart", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { (action) in
            
            guard
                
                let email:String = alert.textFields?.first?.text
            
            else
            {
                return
            }
            
            FIRAuth.auth()?.sendPasswordResetWithEmail(email) { error in
                if let error = error {
                    print("fucking error \(error.localizedDescription)")
                } else {
                    print("reseted!!!")
                }
            }
        }
        
        alert.addTextField
        {
            (textfield) in
            
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionRestart)
        
        present(alert, animated:true, completion:nil)
    }
}
