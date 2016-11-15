import Foundation

class FDatabaseModelPurchaseList:FDatabaseModel
{
    let items:[MStore.PurchaseId:FDatabaseModelPurchase]
    
    required init(snapshot:Any)
    {
        if let rawItems:[MStore.PurchaseId:Any] = snapshot as? [MStore.PurchaseId:Any]
        {
            var items:[MStore.PurchaseId:FDatabaseModelPurchase] = [:]
            let keys:[MStore.PurchaseId] = Array(rawItems.keys)
            
            for rawKey:MStore.PurchaseId in keys
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
