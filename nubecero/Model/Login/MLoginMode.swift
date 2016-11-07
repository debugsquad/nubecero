import Foundation

class MLoginMode
{
    enum ModeType
    {
        case register
        case signin
    }
    
    let name:String
    let modeType:ModeType
    
    class func ModeNames() -> [String]
    {
        let modeRegister:MLoginModeRegister = MLoginModeRegister()
        let modeSignin:MLoginModeSignin = MLoginModeSignin()
        
        let names:[String] = [
            modeRegister.name,
            modeSignin.name
        ]
        
        return names
    }
    
    init()
    {
        fatalError()
    }
    
    init(name:String, modeType:ModeType)
    {
        self.name = name
        self.modeType = modeType
    }
}
