import Foundation

class MPictures
{
    static let sharedInstance:MPictures = MPictures()
    var items:[MPicturesItem]
    
    private init()
    {
        items = []
    }
    
    //MARK: private
    
    private func asyncLoadReferences()
    {
        guard
            
            let userId:String = MSession.sharedInstance.userId
        
        else
        {
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let path:String = "\(parentUser)/\(userId)"
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelUser.self)
        { (model) in
            
        }
    }
    
    //MARK: public
    
    func loadReferences()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoadReferences()
        }
    }
}
