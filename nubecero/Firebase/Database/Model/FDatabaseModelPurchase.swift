import Foundation

class FDatabaseModelPurchase:FDatabaseModel
{
    enum Property:String
    {
        case purchaseId = "purchaseId"
        case name = "name"
        case created = "created"
    }
    
    let purchaseId:MStore.PurchaseId
    let name:String
    let created:TimeInterval
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    
    override init()
    {
        created = NSDate().timeIntervalSince1970
        purchaseId = kEmpty
        name = kEmpty
        
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
            Property.purchaseId.rawValue:purchaseId,
            Property.name.rawValue:name,
            Property.created.rawValue:created
        ]
        
        return json
    }
}
