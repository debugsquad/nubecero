import Foundation

class MAdminPurchases
{
    let items:[MAdminPurchasesItem]
    
    init(purchaseList:FDatabaseModelPurchaseList)
    {
        var items:[MAdminPurchasesItem] = []
        let arrayKeys:[MStore.PurchaseId] = Array(purchaseList.items.keys)
        
        for key:MStore.PurchaseId in arrayKeys
        {
            let firebasePurchase:FDatabaseModelPurchase = purchaseList.items[key]!
            let item:MAdminPurchasesItem = MAdminPurchasesItem(
                purchaseId:key,
                firebasePurchase:firebasePurchase)
            items.append(item)
        }
        
        self.items = items
    }
}
