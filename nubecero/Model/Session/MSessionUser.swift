import Foundation

class MSessionUser
{
    var userId:MSession.UserId?
    
    //MARK: private
    
    private func asyncCreateUser(email:String, userId:MSession.UserId)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let userPath:String = "\(parentUser)/\(userId)"
        
        let modelUser:FDatabaseModelUser = FDatabaseModelUser(
            email:email,
            token: <#T##String?#>,
            version: <#T##String#>)
        
        let json:Any = modelUser.modelJson()
        
        FMain.sharedInstance.database.updateChild(
            path:userPath,
            json:json)
        
        self.userId = userId
        self.loadServer()
    }
    
    private func asyncLoadUser(userId:MSession.UserId)
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
    
    //MARK: public
    
    func createUser(email:String, userId:MSession.UserId)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncCreateUser(email:email, userId:userId)
        }
    }
    
    func loadUser(userId:MSession.UserId)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadUser(userId:userId)
        }
    }
}
