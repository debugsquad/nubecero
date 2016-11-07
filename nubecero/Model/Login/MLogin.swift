import UIKit

class MLogin
{
    let items:[MLoginItem]
    
    class func None() -> MLogin
    {
        let model:MLogin = MLogin(items:[])
        
        return model
    }
    
    class func Register() -> MLogin
    {
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
        
        let model:MLogin = MLogin(items:items)
        
        return model
    }
    
    class func Signup() -> MLogin
    {
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
        
        let model:MLogin = MLogin(items:items)
        
        return model
    }
    
    private init()
    {
        fatalError()
    }
    
    private init(items:[MLoginItem])
    {
        self.items = items
    }
}
