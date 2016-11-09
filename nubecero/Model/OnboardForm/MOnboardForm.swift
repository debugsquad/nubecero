import Foundation

class MOnboardForm
{
    let items:[MOnboardFormItem]
    let title:String
    let buttonMessage:String

    class func Register() -> MOnboardForm
    {
        let title:String = NSLocalizedString("MOnboardForm_titleRegister", comment:"")
        let buttonMessage:String = NSLocalizedString("", comment:"")
        
        let itemEmail:MOnboardFormItemEmailRegister = MOnboardFormItemEmailRegister()
        
        let items:[MOnboardFormItem] = [
            itemEmail
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
        let buttonMessage:String = NSLocalizedString("", comment:"")
        
        let itemEmail:MOnboardFormItemEmailSignin = MOnboardFormItemEmailSignin()
        
        let items:[MOnboardFormItem] = [
            itemEmail
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
