import Foundation

class FDatabaseModelPurchaseList:FDatabaseModel
{
    let items:[FDatabaseModelPurchase.PurchaseId:FDatabaseModelPurchase]
    
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
}
