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
    var server:MSessionServer?
    var userId:UserId?
    var settings:DObjectSettings?
    
    //MARK: private
    
    private func asyncCreateUser(email:String, userId:String)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let userPath:String = "\(parentUser)/\(userId)"
        let modelUser:FDatabaseModelUser = FDatabaseModelUser(
            email:email,
            status:FDatabaseModelUser.Status.active)
        let json:Any = modelUser.modelJson()
        
        FMain.sharedInstance.database.updateChild(
            path:userPath,
            json:json)
        
        self.userId = userId
        self.loadServer()
    }
    
    private func asyncLoadUser(userId:UserId)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyStatus:String = FDatabaseModelUser.Property.status.rawValue
        let userStatusPath:String = "\(parentUser)/\(userId)/\(propertyStatus)"
        
        FMain.sharedInstance.database.listenOnce(
            path:userStatusPath,
            modelType:FDatabaseModelUserStatus.self)
        { (status) in
            
            if let statusStrong:FDatabaseModelUserStatus = status
            {
                switch statusStrong.status
                {
                    case FDatabaseModelUser.Status.active:
                    
                        self.userId = userId
                        self.updateLastSession()
                        
                        break
                    
                    default:
                    
                        NotificationCenter.default.post(
                            name:Notification.userBanned,
                            object:nil)
                        
                        break
                }
            }
            else
            {
                NotificationCenter.default.post(
                    name:Notification.userBanned,
                    object:nil)
            }
        }
    }
    
    private func loadServer()
    {
        let parentServer:String = FDatabase.Parent.server.rawValue
        
        FMain.sharedInstance.database.listenOnce(
            path:parentServer,
            modelType:FDatabaseModelServer.self)
        { (modelServer) in
            
            guard
            
                let firebaseServer:FDatabaseModelServer = modelServer
            
            else
            {
                return
            }
            
            self.server = MSessionServer(firebaseServer:firebaseServer)
            
            NotificationCenter.default.post(
                name:Notification.sessionLoaded,
                object:nil)
        }
    }
    
    private func settingsLoaded()
    {
        NotificationCenter.default.post(
            name:Notification.settingsLoaded,
            object:nil)
    }
    
    private func createSettings()
    {
        DManager.sharedInstance.createManagedObject(
            modelType:DObjectSettings.self)
        { (settings) in
            
            self.settings = settings
            
            DManager.sharedInstance.save()
            self.settingsLoaded()
        }
    }
    
    private func asyncLoadSettings()
    {
        DManager.sharedInstance.fetchManagedObjects(
            modelType:DObjectSettings.self,
            limit:1)
        { (objects) in
            
            guard
            
                let settings:DObjectSettings = objects?.first
            
            else
            {
                self.createSettings()
                
                return
            }
            
            self.settings = settings
            self.settingsLoaded()
        }
    }
    
    //MARK: public
    
    func loadSettings()
    {
        if settings == nil
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.asyncLoadSettings()
            }
        }
    }
    
    func createUser(email:String, userId:UserId)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncCreateUser(email:email, userId:userId)
        }
    }
    
    func loadUser(userId:UserId)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadUser(userId:userId)
        }
    }
    
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
