import UIKit

class MLogin
{
    let items:[MLoginItem]
    let mode:MLoginMode?
    
    class func WithMode(modeType:MLoginMode.ModeType) -> MLogin
    {
        let model:MLogin
        
        switch modeType
        {
            case MLoginMode.ModeType.register:
                
                model = Register()
                
                break
            
            case MLoginMode.ModeType.signin:
            
                model = Signin()
            
                break
        }
        
        return model
    }
    
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
        let itemVoidTop:MLoginItemVoid = MLoginItemVoid()
        let itemEmail:MLoginItemEmail = MLoginItemEmail()
        let itemPassword:MLoginItemPassword = MLoginItemPassword()
        let itemVoidBottom:MLoginItemVoid = MLoginItemVoid()
        let itemSend:MLoginItemSend = MLoginItemSend()
        
        let items:[MLoginItem] = [
            itemMode,
            itemDisclaimer,
            itemVoidTop,
            itemEmail,
            itemPassword,
            itemVoidBottom,
            itemSend
        ]
        
        let model:MLogin = MLogin(items:items, mode:mode)
        
        return model
    }
    
    class func Signin() -> MLogin
    {
        let mode:MLoginModeSignin = MLoginModeSignin()
        let itemMode:MLoginItemMode = MLoginItemMode()
        let itemDisclaimer:MLoginItemDisclaimerSignin = MLoginItemDisclaimerSignin()
        let itemVoidTop:MLoginItemVoid = MLoginItemVoid()
        let itemEmail:MLoginItemEmail = MLoginItemEmail()
        let itemPassword:MLoginItemPassword = MLoginItemPassword()
        let itemVoidBottom:MLoginItemVoid = MLoginItemVoid()
        let itemSend:MLoginItemSend = MLoginItemSend()
        
        let items:[MLoginItem] = [
            itemMode,
            itemDisclaimer,
            itemVoidTop,
            itemEmail,
            itemPassword,
            itemVoidBottom,
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
