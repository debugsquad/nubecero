import UIKit

class MOnboardFormItemEmailSignin:MOnboardFormItemEmail
{
    override init()
    {
        let rememberEmail:String? = MSession.sharedInstance.settings?.lastEmail
        
        super.init(email:rememberEmail)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
    
    override init(email:String?)
    {
        fatalError()
    }
}
