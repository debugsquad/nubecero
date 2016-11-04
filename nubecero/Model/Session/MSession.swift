import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    var server:MSessionServer?
    var userId:String?
    var settings:DObjectSettings?
    private let kServerInitialFroobSize:Int = 10000
    
    private init()
    {
    }
    
    //MARK: private
    
    private func asyncLoadUser(userId:String)
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
                    
                        self.updateLastSession(userId:userId)
                        
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
    
    private func createUser(userId:String)
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
    
    private func updateLastSession(userId:String)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyLastSession:String = FDatabaseModelUser.Property.lastSession.rawValue
        let userPath:String = "\(parentUser)/\(userId)/\(propertyLastSession)"
        let currentTime:TimeInterval = NSDate().timeIntervalSince1970
        
        FMain.sharedInstance.database.updateChild(
            path:userPath,
            json:currentTime)
        
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
                #if DEBUG
                    
                    self.firstTimeServer()
                    
                #endif
                
                return
            }
            
            self.server = MSessionServer(firebaseServer:firebaseServer)
            
            NotificationCenter.default.post(
                name:Notification.sessionLoaded,
                object:nil)
        }
    }
    
    private func firstTimeServer()
    {
        let parentServer:String = FDatabase.Parent.server.rawValue
        let firebaseServer:FDatabaseModelServer = FDatabaseModelServer(
            froobSpace:kServerInitialFroobSize)
        let firebaseServerJson:Any = firebaseServer.modelJson()
        
        FMain.sharedInstance.database.updateChild(
            path:parentServer,
            json:firebaseServerJson)
        
        loadServer()
    }
    
    private func createSettings()
    {
        DManager.sharedInstance.createManagedObject(
            modelType:DObjectSettings.self)
        { (settings) in
            
            self.settings = settings
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
                return
            }
            
            self.settings = settings
        }
    }
    
    //MARK: public
    
    func loadSettings()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadSettings()
        }
    }
    
    func loadUser(userId:String)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadUser(userId:userId)
        }
    }
}
