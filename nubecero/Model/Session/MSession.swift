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
                print("user not existing")
            }
            else
            {
                print("user loaded")
            }
        }
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
