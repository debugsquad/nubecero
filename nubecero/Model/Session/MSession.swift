import Foundation

class MSession
{
    enum Status:Int
    {
        case unknown
        case active
        case banned
    }
    
    typealias UserId = String
    
    static let sharedInstance:MSession = MSession()
    let user:MSessionUser
    let storage:MSessionStorage
    let settings:MSessionSettings
    let server:MSessionServer
    let version:String
    private let kVersionKey:String = "CFBundleVersion"
    private let kEmpty:String = ""
    
    private init()
    {
        user = MSessionUser()
        storage = MSessionStorage()
        settings = MSessionSettings()
        server = MSessionServer()
        
        if let version:String = Bundle.main.infoDictionary?[kVersionKey] as? String
        {
            self.version = version
        }
        else
        {
            self.version = kEmpty
        }
    }
    
    //MARK: private
    
    
    
    
    
    
    
    
    
    //MARK: public
    
    
    
    
    
    func totalStorage() -> Int
    {
        var space:Int = 0
        
        guard
        
            let froobSpace:Int = server?.froobSpace,
            let plusSpace:Int = server?.plusSpace
        
        else
        {
            return space
        }
        
        space += froobSpace
        
        if let nubeceroPlus:Bool = settings?.nubeceroPlus
        {
            if nubeceroPlus
            {
                space += plusSpace
            }
        }
        
        return space
    }
}
