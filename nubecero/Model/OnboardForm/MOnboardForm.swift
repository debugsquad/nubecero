import Foundation

class MOnboardForm
{
    let items:[MOnboardFormItem]
    let title:String
    let buttonMessage:String
    weak var itemEmail:MOnboardFormItemEmail!
    weak var itemPassword:MOnboardFormItemPassword!
    private let kEmailMinLength:Int = 4
    private let kPasswordMinLength:Int = 6

    class func Register() -> MOnboardForm
    {
        let title:String = NSLocalizedString("MOnboardForm_titleRegister", comment:"")
        let buttonMessage:String = NSLocalizedString("MOnboardForm_buttonRegister", comment:"")
        
        let itemEmail:MOnboardFormItemEmailRegister = MOnboardFormItemEmailRegister()
        let itemPassword:MOnboardFormItemPasswordRegister = MOnboardFormItemPasswordRegister()
        
        let items:[MOnboardFormItem] = [
            itemEmail,
            itemPassword
        ]
        
        let model:MOnboardForm = MOnboardForm(
            items:items,
            title:title,
            buttonMessage:buttonMessage,
            itemEmail:itemEmail,
            itemPassword:itemPassword)
        
        return model
    }
    
    class func Signin() -> MOnboardForm
    {
        let title:String = NSLocalizedString("MOnboardForm_titleSignin", comment:"")
        let buttonMessage:String = NSLocalizedString("MOnboardForm_buttonSignin", comment:"")
        
        let itemEmail:MOnboardFormItemEmailSignin = MOnboardFormItemEmailSignin()
        let itemPassword:MOnboardFormItemPasswordSignin = MOnboardFormItemPasswordSignin()
        
        let items:[MOnboardFormItem] = [
            itemEmail,
            itemPassword
        ]
        
        let model:MOnboardForm = MOnboardForm(
            items:items,
            title:title,
            buttonMessage:buttonMessage,
            itemEmail:itemEmail,
            itemPassword:itemPassword)
        
        return model
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: private
    
    private init(items:[MOnboardFormItem], title:String, buttonMessage:String, itemEmail:MOnboardFormItemEmail, itemPassword:MOnboardFormItemPassword)
    {
        self.items = items
        self.title = title
        self.buttonMessage = buttonMessage
        self.itemEmail = itemEmail
        self.itemPassword = itemPassword
    }
    
    //MARK: public
    
    func createCredentials(completion:@escaping((MOnboardFormCredentials?, String?) -> ()))
    {
        let emailMinLength:Int = kEmailMinLength
        let passwordMinLength:Int = kPasswordMinLength
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            let credentials:MOnboardFormCredentials?
            let errorString:String?
            
            guard
            
                let email:String = self?.itemEmail.email
            
            else
            {
                credentials = nil
                errorString = NSLocalizedString("MOnboardForm_errorEmail", comment:"")
                completion(credentials, errorString)
                
                return
            }
            
            if email.characters.count < emailMinLength
            {
                credentials = nil
                errorString = NSLocalizedString("MOnboardForm_errorEmailShort", comment:"")
                completion(credentials, errorString)
                
                return
            }
            
            guard
            
                let password:String = self?.itemPassword.password
            
            else
            {
                credentials = nil
                errorString = NSLocalizedString("MOnboardForm_errorPassword", comment:"")
                completion(credentials, errorString)
                
                return
            }
            
            if password.characters.count < passwordMinLength
            {
                credentials = nil
                errorString = NSLocalizedString("MOnboardForm_errorPasswordShort", comment:"")
                completion(credentials, errorString)
                
                return
            }
            
            credentials = MOnboardFormCredentials(
                email:email,
                password:password)
            errorString = nil
            
            completion(credentials, errorString)
        }
    }
}
