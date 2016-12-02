import Foundation

class FDatabaseModelAlbum:FDatabaseModel
{
    enum Property:String
    {
        case created = "created"
        case name = "name"
    }
    
    let created:TimeInterval
    let name:String
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    
    init(name:String)
    {
        created = NSDate().timeIntervalSince1970
        self.name = name
        
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
        
        if let name:String = snapshotDict?[Property.name.rawValue] as? String
        {
            self.name = name
        }
        else
        {
            self.name = kEmpty
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
            Property.created.rawValue:created,
            Property.name.rawValue:name
        ]
        
        return json
    }
}
