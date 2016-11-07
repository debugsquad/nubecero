import Foundation

class MLoginModeRegister:MLoginMode
{
    override init()
    {
        let name:String = NSLocalizedString("MLoginModeRegister_name", comment:"")
        super.init(name:name)
    }
}
