import UIKit

class MOnboardFormItemPasswordSignin:MOnboardFormItemPassword
{
    override init()
    {
        let rememberPassword:String? = MSession.sharedInstance.settings?.lastPassword
        
        super.init(password:rememberPassword)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
    
    override init(password:String?)
    {
        fatalError()
    }
}
