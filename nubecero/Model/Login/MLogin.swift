import UIKit

class MLogin
{
    let items:[MLoginItem]
    let mode:MLoginMode?
    
    class func None() -> MLogin
    {
        let model:MLogin = MLogin(items:[], mode:nil)
        
        return model
    }
    
    class func Register() -> MLogin
    {
        let mode:MLoginMode = MLoginModeRegister()
        let itemMode:MLoginItemMode = MLoginItemMode()
        let itemDisclaimer:MLoginItemDisclaimerRegister = MLoginItemDisclaimerRegister()
        let itemEmail:MLoginItemEmail = MLoginItemEmail()
        let itemPassword:MLoginItemPassword = MLoginItemPassword()
        let itemSend:MLoginItemSend = MLoginItemSend()
        
        let items:[MLoginItem] = [
            itemMode,
            itemDisclaimer,
            itemEmail,
            itemPassword,
            itemSend
        ]
        
        let model:MLogin = MLogin(items:items, mode:mode)
        
        return model
    }
    
    class func Signup() -> MLogin
    {
        let mode:MLoginModeSignup = MLoginModeSignup()
        let itemMode:MLoginItemMode = MLoginItemMode()
        let itemDisclaimer:MLoginItemDisclaimerSignup = MLoginItemDisclaimerSignup()
        let itemEmail:MLoginItemEmail = MLoginItemEmail()
        let itemPassword:MLoginItemPassword = MLoginItemPassword()
        let itemSend:MLoginItemSend = MLoginItemSend()
        
        let items:[MLoginItem] = [
            itemMode,
            itemDisclaimer,
            itemEmail,
            itemPassword,
            itemSend
        ]
        
        let model:MLogin = MLogin(items:items, mode:mode)
        
        return model
    }
    
    private init()
    {
        fatalError()
    }
    
    private init(items:[MLoginItem], mode:MLoginMode?)
    {
        self.items = items
        self.mode = mode
    }
}
