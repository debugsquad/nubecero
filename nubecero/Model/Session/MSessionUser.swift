import Foundation

class MSessionUser
{
    var status:MSession.Status
    var userId:MSession.UserId?
    var token:String?
    var ttl:Int?
    
    init()
    {
        status = MSession.Status.unknown
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
                    case MSession.Status.active:
                        
                        self.status = receivedSession.status
                        self.ttl = receivedSession.ttl
                        
                        if !receivedSession.token.isEmpty
                        {
                            self.token = receivedSession.token
                        }
                        
                        self.sendUpdate()
                        
                        break
                        
                    default:
                        
                        self.banned()
                        
                        break
                }
            }
            else
            {
                self.banned()
            }
        }
    }
    
    private func asyncSendUpdate()
    {
        guard
            
            let userId:MSession.UserId = self.userId,
            var ttl:Int = self.ttl
            
        else
        {
            return
        }
        
        ttl += 1
        
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyLastSession:String = FDatabaseModelUser.Property.lastSession.rawValue
        let lastSessionPath:String = "\(parentUser)/\(userId)/\(propertyLastSession)"
        let currentTime:TimeInterval = NSDate().timeIntervalSince1970
        
        FMain.sharedInstance.database.updateChild(
            path:lastSessionPath,
            json:currentTime)
        
        self.loadServer()
    }
    
    private func banned()
    {
        FMain.sharedInstance.analytics?.sessionBanned()
        
        NotificationCenter.default.post(
            name:Notification.userBanned,
            object:nil)
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
    
    func sendUpdate()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncSendUpdate()
        }
    }
}
