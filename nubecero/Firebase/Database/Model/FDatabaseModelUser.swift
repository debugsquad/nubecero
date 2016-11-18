import Foundation

class FDatabaseModelUser:FDatabaseModel
{
    enum Property:String
    {
        case email = "email"
        case token = "token"
        case status = "status"
        case created = "created"
        case lastSession = "lastSession"
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
    
    let email:String
    let created:TimeInterval
    let lastSession:TimeInterval
    let status:Status
    let diskUsed:Int
    private let kNoTime:TimeInterval = 0
    private let kEmpty:String = ""
    
    init(email:String, status:Status)
    {
        self.email = email
        self.status = status
        created = NSDate().timeIntervalSince1970
        lastSession = created
        diskUsed = 0
        
        super.init()
    }
    
    required init(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
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
    
    override init()
    {
        fatalError()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.email.rawValue:email,
            Property.status.rawValue:status.rawValue,
            Property.created.rawValue:created,
            Property.lastSession.rawValue:lastSession,
            Property.diskUsed.rawValue:diskUsed
        ]
        
        return json
    }
}
