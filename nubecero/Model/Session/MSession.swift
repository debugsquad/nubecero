import Foundation

class MSession
{
    typealias UserId = String
    
    static let sharedInstance:MSession = MSession()
    var server:MSessionServer?
    var userId:UserId?
    var plus:Bool
    var settings:DObjectSettings?
    
    private init()
    {
        plus = false
    }
    
    //MARK: private
    
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
                        self.loadPerks()
                        
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
                self.createUser(userId:userId)
            }
        }
    }
    
    private func createUser(userId:UserId)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let userPath:String = "\(parentUser)/\(userId)"
        let modelUser:FDatabaseModelUser = FDatabaseModelUser(
            status:FDatabaseModelUser.Status.active)
        let json:Any = modelUser.modelJson()
        
        FMain.sharedInstance.database.updateChild(
            path:userPath,
            json:json)
        
        self.userId = userId
        self.loadServer()
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
    
    private func updateLastSession()
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
        
            let froobSpace:Int = server?.froobSpace
        
        else
        {
            return space
        }
        
        space += froobSpace
        
        return space
    }
    
    func loadPerks()
    {
        guard
            
            let userId:UserId = self.userId
            
        else
        {
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPlus:String = FDatabaseModelUser.Property.plus.rawValue
        let plusPath:String = "\(parentUser)/\(userId)/\(propertyPlus)"
        
        FMain.sharedInstance.database.listenOnce(
            path:plusPath,
            modelType:FDatabaseModelUserPlus.self)
        { (plus) in
            
            if let plusStrong:FDatabaseModelUserPlus = plus
            {
                self.plus = plusStrong.plus
            }
            else
            {
                self.plus = false
            }
            
            self.updateLastSession()
        }
    }
    
    func purchasePlus()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let userId:UserId = self.userId
                
            else
            {
                return
            }
            
            let parentUser:String = FDatabase.Parent.user.rawValue
            let propertyPlus:String = FDatabaseModelUser.Property.plus.rawValue
            let plusPath:String = "\(parentUser)/\(userId)/\(propertyPlus)"
            let firebasePlus:FDatabaseModelUserPlus = FDatabaseModelUserPlus()
            let plusJson:Any = firebasePlus.modelJson()
            
            FMain.sharedInstance.database.updateChild(
                path:plusPath,
                json:plusJson)
        }
    }
}
