import Foundation

class MLoginMode
{
    let name:String
    
    class func ModeNames() -> [String]
    {
        let modeRegister:MLoginModeRegister = MLoginModeRegister()
        let modeSignup:MLoginModeSignup = MLoginModeSignup()
        
        let names:[String] = [
            modeRegister.name,
            modeSignup.name
        ]
        
        return names
    }
    
    init()
    {
        fatalError()
    }
    
    init(name:String)
    {
        self.name = name
    }
}
