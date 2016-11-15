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
        
        if let purchaseId:MStore.PurchaseId = snapshotDict?[Property.purchaseId.rawValue] as? MStore.PurchaseId
        {
            self.purchaseId = purchaseId
        }
        else
        {
            self.purchaseId = kEmpty
        }
        
        if let name:String = snapshotDict?[Property.name.rawValue] as? String
        {
            self.name = name
        }
        else
        {
            self.name = kEmpty
        }
        
        if let created:TimeInterval = snapshotDict?[Property.created.rawValue] as? TimeInterval
        {
            self.created = created
        }
        else
        {
            self.created = kNoTime
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
