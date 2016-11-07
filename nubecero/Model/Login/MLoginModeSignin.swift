import Foundation

class MLoginModeSignin:MLoginMode
{
    override init()
    {
        let name:String = NSLocalizedString("MLoginModeSignin_name", comment:"")
        super.init(name:name)
    }
}
