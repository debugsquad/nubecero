import UIKit

class MOnboardFormItemPasswordSignin:MOnboardFormItemPassword
{
    override init()
    {
        super.init(password:nil)
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
