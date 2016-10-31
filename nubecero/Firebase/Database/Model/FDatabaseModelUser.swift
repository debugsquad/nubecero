import Foundation

class FDatabaseModelUser:FDatabaseModel
{
    let created:TimeInterval
    let lastSession:TimeInterval
    private let kNoTime:TimeInterval = 0
    
    enum Property:String
    {
        case created = "created"
        case lastSession = "lastSession"
        case pictures = "pictures"
    }
    
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
