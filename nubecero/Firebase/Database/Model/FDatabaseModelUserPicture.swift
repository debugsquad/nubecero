import Foundation

class FDatabaseModelPicture:FDatabaseModel
{
    enum Status:Int
    {
        case waiting
        case uploaded
    }
    
    enum Property:String
    {
        case created = "created"
        case status = "status"
        case size = "size"
    }
    
    let created:TimeInterval
    private let kNoTime:TimeInterval = 0
    
    override init()
    {
        created = NSDate().timeIntervalSince1970
        lastSession = created
        
        super.init()
    }
    
    required init(snapshot:Any?)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let created:TimeInterval = snapshotDict?[Property.created.rawValue] as? TimeInterval
        {
            self.created = created
        }
        else
        {
            self.created = kNoTime
        }
        
        if let lastSession:TimeInterval = snapshotDict?[Property.lastSession.rawValue] as? TimeInterval
        {
            self.lastSession = lastSession
        }
        else
        {
            self.lastSession = kNoTime
        }
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.created.rawValue:created,
            Property.lastSession.rawValue:lastSession
        ]
        
        return json
    }
}
