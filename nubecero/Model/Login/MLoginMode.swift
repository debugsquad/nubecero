import Foundation

class MLoginMode
{
    let name:String
    
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
    
    init(name:String)
    {
        self.name = name
    }
}
