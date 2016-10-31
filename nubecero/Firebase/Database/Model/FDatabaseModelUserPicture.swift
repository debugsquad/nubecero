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
    let status:Status
    let size:Int
    private let kNoTime:TimeInterval = 0
    
    init(size:Int)
    {
        created = NSDate().timeIntervalSince1970
        status = Status.waiting
        self.size = size
        
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
        
        if let statusInt:Int = snapshotDict?[Property.status.rawValue] as? Int
        {
            if let status:Status = Status(rawValue:statusInt)
            {
                self.status = status
            }
            else
            {
                self.status = Status.waiting
            }
        }
        else
        {
            self.status = Status.waiting
        }
        
        if let size:Int = snapshotDict?[Property.size.rawValue] as? Int
        {
            self.size = size
        }
        else
        {
            self.size = 0
        }
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.created.rawValue:created,
            Property.status.rawValue:status.rawValue,
            Property.size.rawValue:size
        ]
        
        return json
    }
}
