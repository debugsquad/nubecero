import Foundation

class FDatabaseModelUser:FDatabaseModel
{
    enum Property:String
    {
        case created = "created"
        case lastSession = "lastSession"
        case diskUsed = "diskUsed"
        case pictures = "pictures"
    }
    
    let created:TimeInterval
    let lastSession:TimeInterval
    let diskUsed:Int
    private let kNoTime:TimeInterval = 0
    
    override init()
    {
        created = NSDate().timeIntervalSince1970
        lastSession = created
        diskUsed = 0
        
        super.init()
    }
    
    required init(snapshot:Any)
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
        
        if let diskUsed:Int = snapshotDict?[Property.diskUsed.rawValue] as? Int
        {
            self.diskUsed = diskUsed
        }
        else
        {
            self.diskUsed = 0
        }
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.created.rawValue:created,
            Property.lastSession.rawValue:lastSession,
            Property.diskUsed.rawValue:diskUsed
        ]
        
        return json
    }
}
