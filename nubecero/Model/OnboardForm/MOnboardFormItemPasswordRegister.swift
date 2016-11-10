import UIKit

class MOnboardFormItemPasswordRegister:MOnboardFormItemPassword
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
