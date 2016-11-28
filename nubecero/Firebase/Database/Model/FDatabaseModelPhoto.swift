import Foundation

class FDatabaseModelPhoto:FDatabaseModel
{
    enum Property:String
    {
        case localId = "localId"
        case albumId = "albumId"
        case created = "created"
        case taken = "taken"
        case status = "status"
        case size = "size"
        case pixelWidth = "pixelWidth"
        case pixelHeight = "pixelHeight"
    }
    
    let albumId:MPhotos.AlbumId
    let localId:MPhotos.LocalId
    let created:TimeInterval
    let taken:TimeInterval
    let status:MPhotos.Status
    let size:Int
    let pixelWidth:Int
    let pixelHeight:Int
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    private let kZero:Int = 0
    
    init(
        localId:MPhotos.LocalId,
        taken:TimeInterval,
        size:Int,
        pixelWidth:Int,
        pixelHeight:Int)
    {
        self.localId = localId
        self.taken = taken
        self.size = size
        self.pixelWidth = pixelWidth
        self.pixelHeight = pixelHeight
        albumId = kEmpty
        created = NSDate().timeIntervalSince1970
        status = MPhotos.Status.waiting
        
        super.init()
    }
    
    required init(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let localId:MPhotos.LocalId = snapshotDict?[Property.localId.rawValue] as? MPhotos.LocalId
        {
            self.localId = localId
        }
        else
        {
            self.localId = kEmpty
        }
        
        if let albumId:MPhotos.AlbumId = snapshotDict?[Property.albumId.rawValue] as? MPhotos.AlbumId
        {
            self.albumId = albumId
        }
        else
        {
            self.albumId = kEmpty
        }
        
        if let created:TimeInterval = snapshotDict?[Property.created.rawValue] as? TimeInterval
        {
            self.created = created
        }
        else
        {
            self.created = kNoTime
        }
        
        if let taken:TimeInterval = snapshotDict?[Property.taken.rawValue] as? TimeInterval
        {
            self.taken = taken
        }
        else
        {
            self.taken = kNoTime
        }
        
        if let statusInt:Int = snapshotDict?[Property.status.rawValue] as? Int
        {
            if let status:MPhotos.Status = MPhotos.Status(rawValue:statusInt)
            {
                self.status = status
            }
            else
            {
                self.status = MPhotos.Status.waiting
            }
        }
        else
        {
            self.status = MPhotos.Status.waiting
        }
        
        if let size:Int = snapshotDict?[Property.size.rawValue] as? Int
        {
            self.size = size
        }
        else
        {
            self.size = 0
        }
        
        if let pixelWidth:Int = snapshotDict?[Property.pixelWidth.rawValue] as? Int
        {
            self.pixelWidth = pixelWidth
        }
        else
        {
            self.pixelWidth = 0
        }
        
        if let pixelHeight:Int = snapshotDict?[Property.pixelHeight.rawValue] as? Int
        {
            self.pixelHeight = pixelHeight
        }
        else
        {
            self.pixelHeight = 0
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
            Property.localId.rawValue:localId,
            Property.albumId.rawValue:albumId,
            Property.created.rawValue:created,
            Property.taken.rawValue:taken,
            Property.status.rawValue:status.rawValue,
            Property.size.rawValue:size,
            Property.pixelWidth.rawValue:pixelWidth,
            Property.pixelHeight.rawValue:pixelHeight
        ]
        
        return json
    }
}
