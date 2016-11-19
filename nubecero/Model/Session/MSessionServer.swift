import Foundation

class MSessionServer
{
    var froobSpace:Int
    var plusSpace:Int
    private let kZero:Int = 0
    
    init()
    {
        froobSpace = kZero
        plusSpace = kZero
    }
    
    //MARK: private
    
    private func asyncLoadServer()
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
            
            self.froobSpace = firebaseServer.froobSpace
            self.plusSpace = firebaseServer.plusSpace
            
            NotificationCenter.default.post(
                name:Notification.sessionLoaded,
                object:nil)
        }
    }
    
    //MARK: public
    
    func loadServer()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadServer()
        }
    }
}
