import Foundation

class FDatabaseModelPurchaseList:FDatabaseModel
{
    let items:[FDatabaseModelPurchase.PurchaseId:FDatabaseModelPurchase]
    
    init(purchases:[MAdminPurchasesItem])
    {
        var items:[FDatabaseModelPurchase.PurchaseId:FDatabaseModelPurchase] = [:]
        
        for purchase:MAdminPurchasesItem in purchases
        {
            let purchaseId:FDatabaseModelPurchase.PurchaseId = purchase.firebasePurchaseId
            let item:FDatabaseModelPurchase = FDatabaseModelPurchase(
                purchase:purchase)
            items[purchaseId] = item
        }
        
        self.items = items
        
        super.init()
    }
    
    required init(snapshot:Any)
    {
        if let rawItems:[FDatabaseModelPurchase.PurchaseId:Any] = snapshot as? [FDatabaseModelPurchase.PurchaseId:Any]
        {
            var items:[FDatabaseModelPurchase.PurchaseId:FDatabaseModelPurchase] = [:]
            let keys:[FDatabaseModelPurchase.PurchaseId] = Array(rawItems.keys)
            
            for rawKey:FDatabaseModelPurchase.PurchaseId in keys
            {
                let rawItem:Any = rawItems[rawKey]
                let item:FDatabaseModelPurchase = FDatabaseModelPurchase(snapshot:rawItem)
                items[rawKey] = item
            }
            
            self.items = items
        }
        else
        {
            items = [:]
        }
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
    
    override func modelJson() -> Any
    {
        let itemsKeys:[FDatabaseModelPurchase.PurchaseId] = Array(items.keys)
        var json:[String:Any] = [:]
        
        for itemKey:FDatabaseModelPurchase.PurchaseId in itemsKeys
        {
            let item:FDatabaseModelPurchase = items[itemKey]!
            let jsonItem:Any = item.modelJson()
            json[itemKey] = jsonItem
        }
        
        return json
    }
}
