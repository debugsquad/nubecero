import Foundation
import Firebase

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
    
    func updateLastSession()
    {
        guard
            
            let userId:UserId = self.userId
            
        else
        {
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyLastSession:String = FDatabaseModelUser.Property.lastSession.rawValue
        let lastSessionPath:String = "\(parentUser)/\(userId)/\(propertyLastSession)"
        let currentTime:TimeInterval = NSDate().timeIntervalSince1970
        
        FMain.sharedInstance.database.updateChild(
            path:lastSessionPath,
            json:currentTime)
        
        self.loadServer()
    }
    
    func updateUserToken()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            if self.userToken == nil
            {
                guard
                    
                    let userId:MSession.UserId = self.userId,
                    let token:String = FIRInstanceID.instanceID().token()
                    
                else
                {
                    return
                }
                
                self.userToken = token
                let parentUser:String = FDatabase.Parent.user.rawValue
                let propertyToken:String = FDatabaseModelUser.Property.token.rawValue
                let pathToken:String = "\(parentUser)/\(userId)/\(propertyToken)"
                let modelToken:FDatabaseModelToken = FDatabaseModelToken(token:token)
                let tokenJson:Any = modelToken.modelJson()
                
                FMain.sharedInstance.database.updateChild(
                    path:pathToken,
                    json:tokenJson)
            }
        }
    }
}
