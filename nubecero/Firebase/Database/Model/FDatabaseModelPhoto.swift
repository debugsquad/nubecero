import Foundation

class FDatabaseModelPhoto:FDatabaseModel
{
    enum Property:String
    {
        case album = "album"
        case created = "created"
        case status = "status"
        case size = "size"
    }
    
    enum Status:Int
    {
        case waiting
        case synced
    }
    
    let album:MPhotos.AlbumId
    let created:TimeInterval
    let status:Status
    let size:Int
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    
    init(size:Int)
    {
        self.size = size
        album = kEmpty
        created = NSDate().timeIntervalSince1970
        status = Status.waiting
        
        super.init()
    }
    
    required init(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let album:MPhotos.AlbumId = snapshotDict?[Property.album.rawValue] as? MPhotos.AlbumId
        {
            self.album = album
        }
        else
        {
            self.album = kEmpty
        }
        
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
    
    override init()
    {
        fatalError()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.album.rawValue:album,
            Property.created.rawValue:created,
            Property.status.rawValue:status.rawValue,
            Property.size.rawValue:size
        ]
        
        return json
    }
}
