import Foundation

class MAdminPurchases
{
    let items:[MAdminPurchasesItem]
    
    init(purchaseList:FDatabaseModelPurchaseList)
    {
        var items:[MAdminPurchasesItem] = []
        let arrayKeys:[FDatabaseModelPurchase.PurchaseId] = Array(purchaseList.items.keys)
        
        for key:FDatabaseModelPurchase.PurchaseId in arrayKeys
        {
            let firebasePurchase:FDatabaseModelPurchase = purchaseList.items[key]!
            let item:MAdminPurchasesItem = MAdminPurchasesItem(
                firebasePurchaseId:key,
                firebasePurchase:firebasePurchase)
            items.append(item)
        }
        
        self.items = items
    }
}
