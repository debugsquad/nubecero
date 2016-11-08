import Foundation

class MLoginModeRegister:MLoginMode
{
    private let kModeType:MLoginMode.ModeType = MLoginMode.ModeType.register
    
    override init()
    {
        let name:String = NSLocalizedString("MLoginModeRegister_name", comment:"")
        super.init(name:name, modeType:kModeType)
    }
}
