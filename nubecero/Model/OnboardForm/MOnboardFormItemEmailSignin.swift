import Foundation

class MOnboardFormItemEmailSignin:MOnboardFormItemEmail
{
    override init()
    {
        super.init(email:nil)
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
