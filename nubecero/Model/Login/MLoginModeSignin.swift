import Foundation

class MLoginModeSignin:MLoginMode
{
    private let kModeType:MLoginMode.ModeType = MLoginMode.ModeType.signin
    
    override init(name:String, modeType:ModeType)
    {
        fatalError()
    }
    
    override init()
    {
        let name:String = NSLocalizedString("MLoginModeSignin_name", comment:"")
        super.init(name:name, modeType:kModeType)
    }
}
