import Foundation

class FDatabaseModelUser:FDatabaseModel
{
    enum Property:String
    {
        case session = "session"
        case email = "email"
        case status = "status"
        case created = "created"
        case diskUsed = "diskUsed"
        case photos = "photos"
        case albums = "albums"
    }
    
    enum Status:Int
    {
        case unknown
        case active
        case banned
    }
    
    let session:FDatabaseModelUserSession
    let email:String
    let created:TimeInterval
    let status:Status
    let diskUsed:Int
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    
    init(email:String, status:Status, token:String?, version:String)
    {
        self.session = FDatabaseModelUserSession(
            token:token,
            version:version,
            ttl:nil)
        self.email = email
        self.status = status
        created = NSDate().timeIntervalSince1970
        diskUsed = 0
        
        super.init()
    }
    
    required init(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let sessionSnapshot:[String:Any] = snapshotDict?[Property.session.rawValue] as? [String:Any]
        {
            self.session = FDatabaseModelUserSession(snapshot:sessionSnapshot)
        }
        else
        {
            self.session = FDatabaseModelUserSession(snapshot:[])
        }
        
        if let email:String = snapshotDict?[Property.email.rawValue] as? String
        {
            self.email = email
        }
        else
        {
            self.email = kEmpty
        }
        
        if let statusInt:Int = snapshotDict?[Property.status.rawValue] as? Int
        {
            if let status:Status = Status(rawValue:statusInt)
            {
                self.status = status
            }
            else
            {
                self.status = Status.unknown
            }
        }
        else
        {
            self.status = Status.unknown
        }
        
        if let created:TimeInterval = snapshotDict?[Property.created.rawValue] as? TimeInterval
        {
            self.created = created
        }
        else
        {
            self.created = kNoTime
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
    
    override init()
    {
        fatalError()
    }
    
    override func modelJson() -> Any
    {
        let sessionJson:Any = session.modelJson()
        
        let json:[String:Any] = [
            Property.session.rawValue:sessionJson,
            Property.email.rawValue:email,
            Property.status.rawValue:status.rawValue,
            Property.created.rawValue:created,
            Property.diskUsed.rawValue:diskUsed
        ]
        
        return json
    }
}
