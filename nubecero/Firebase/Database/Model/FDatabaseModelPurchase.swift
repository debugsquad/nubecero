import Foundation

class FDatabaseModelPurchase:FDatabaseModel
{
    typealias PurchaseId = String
    
    enum Property:String
    {
        case purchaseId = "purchaseId"
        case name = "name"
        case created = "created"
        case status = "status"
    }
    
    enum Status:Int
    {
        case hidden
        case active
    }
    
    let purchaseId:MStore.PurchaseId
    let name:String
    let created:TimeInterval
    let status:Status
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    
    init(purchase:MAdminPurchasesItem)
    {
        
    }
    
    override init()
    {
        created = NSDate().timeIntervalSince1970
        purchaseId = kEmpty
        name = kEmpty
        status = Status.hidden
        
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
        
        if let statusInt:Int = snapshotDict?[Property.status.rawValue] as? Int
        {
            if let status:Status = Status(rawValue:statusInt)
            {
                self.status = status
            }
            else
            {
                self.status = Status.hidden
            }
        }
        else
        {
            self.status = Status.hidden
        }
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.purchaseId.rawValue:purchaseId,
            Property.name.rawValue:name,
            Property.created.rawValue:created,
            Property.status.rawValue:status.rawValue
        ]
        
        return json
    }
}
