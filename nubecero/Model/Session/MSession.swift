import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    var server:MSessionServer?
    var userId:String?
    private let kServerInitialFroobSize:Int = 10000
    
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
    
    //MARK: public
    
    func loadUser(userId:String)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadUser(userId:userId)
        }
    }
}
