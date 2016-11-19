import Foundation

class FDatabaseModelUserSession:FDatabaseModel
{
    enum Property:String
    {
        case token = "token"
        case version = "version"
        case timestamp = "timestamp"
        case ttl = "ttl"
    }
    
    let token:String
    let version:String
    let timestamp:TimeInterval
    let ttl:Int
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    private let kFirstTtl = 0
    
    init(token:String?, version:String, ttl:Int?)
    {
        if let receivedToken:String = token
        {
            self.token = receivedToken
        }
        else
        {
            self.token = kEmpty
        }
        
        if let receivedTtl:Int = ttl
        {
            self.ttl = receivedTtl
        }
        else
        {
            self.ttl = kFirstTtl
        }
        
        self.version = version
        timestamp = NSDate().timeIntervalSince1970
        
        super.init()
    }
    
    required init(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let token:String = snapshotDict?[Property.token.rawValue] as? String
        {
            self.token = token
        }
        else
        {
            self.token = kEmpty
        }
        
        if let version:String = snapshotDict?[Property.version.rawValue] as? String
        {
            self.version = version
        }
        else
        {
            self.version = kEmpty
        }
        
        if let timestamp:TimeInterval = snapshotDict?[Property.timestamp.rawValue] as? TimeInterval
        {
            self.timestamp = timestamp
        }
        else
        {
            self.timestamp = kNoTime
        }
        
        if let ttl:Int = snapshotDict?[Property.ttl.rawValue] as? Int
        {
            self.ttl = ttl
        }
        else
        {
            self.ttl = kFirstTtl
        }
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.token.rawValue:token,
            Property.version.rawValue:version,
            Property.timestamp.rawValue:timestamp,
            Property.ttl.rawValue:ttl,
        ]
        
        return json
    }
}
