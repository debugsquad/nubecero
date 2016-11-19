import Foundation

class MSessionUser
{
    var status:MSession.Status
    var userId:MSession.UserId?
    var token:String?
    var ttl:Int
    private let kZero:Int = 0
    
    init()
    {
        status = MSession.Status.unknown
        ttl = kZero
    }
    
    //MARK: private
    
    private func asyncCreateUser(email:String)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let userPath:String = "\(parentUser)/\(userId)"
        let version:String = MSession.sharedInstance.version
        
        let modelUser:FDatabaseModelUser = FDatabaseModelUser(
            email:email,
            token:token,
            version:version)
        ttl = modelUser.session.ttl
        
        let userJson:Any = modelUser.modelJson()
        
        FMain.sharedInstance.database.updateChild(
            path:userPath,
            json:userJson)
        
        MSession.sharedInstance.server.loadServer()
    }
    
    private func asyncLoadUser()
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertySession:String = FDatabaseModelUser.Property.session.rawValue
        let userStatusPath:String = "\(parentUser)/\(userId)/\(propertySession)"
        
        FMain.sharedInstance.database.listenOnce(
            path:userStatusPath,
            modelType:FDatabaseModelUserSession.self)
        { (session) in
            
            if let receivedSession:FDatabaseModelUserSession = session
            {
                switch receivedSession.status
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
    
    //MARK: public
    
    func createUser(email:String, userId:MSession.UserId)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.userId = userId
            self.asyncCreateUser(email:email)
        }
    }
    
    func loadUser(userId:MSession.UserId)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.userId = userId
            self.asyncLoadUser()
        }
    }
}
