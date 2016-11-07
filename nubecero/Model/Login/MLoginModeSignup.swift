import Foundation

class MLoginModeSignup:MLoginMode
{
    override init()
    {
        let name:String = NSLocalizedString("MLoginModeSignup_name", comment:"")
        super.init(name:name)
    }
}
