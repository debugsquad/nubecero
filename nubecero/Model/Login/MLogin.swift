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
        let items:[MLoginItem] = []
        let model:MLogin = MLogin(items:items)
        
        return model
    }
    
    class func Signup() -> MLogin
    {
        let items:[MLoginItem] = []
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
