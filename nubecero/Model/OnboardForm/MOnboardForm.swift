import Foundation

class MOnboardForm
{
    let items:[MOnboardFormItem]
    let title:String
    let buttonMessage:String

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
            buttonMessage:buttonMessage)
        
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
            buttonMessage:buttonMessage)
        
        return model
    }
    
    init()
    {
        fatalError()
    }
    
    private init(items:[MOnboardFormItem], title:String, buttonMessage:String)
    {
        self.items = items
        self.title = title
        self.buttonMessage = buttonMessage
    }
}
