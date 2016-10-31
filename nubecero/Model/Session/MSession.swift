import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    var userId:String?
    
    private init()
    {
    }
    
    //MARK: private
    
    private func asyncLoadUser(userId:String)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let userPath:String = "\(parentUser)/\(userId)"
        
        FMain.sharedInstance.database.listenOnce(
            path:userPath,
            modelType:FDatabaseModelUser.self)
        { (modelUser) in
            
            if modelUser == nil
            {
                self.createUser(userId:userId)
            }
            else
            {
                self.updateLastSession(userId:userId)
            }
        }
    }
    
    private func createUser(userId:String)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let userPath:String = "\(parentUser)/\(userId)"
        let modelUser:FDatabaseModelUser = FDatabaseModelUser()
        let json:Any = modelUser.modelJson()
        
        FMain.sharedInstance.database.updateChild(
            path:userPath,
            json:json)
        
        self.userId = userId
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
    }
    
    //MARK: public
    
    func loadUser(userId:String)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadUser(userId:userId)
        }
    }
}
