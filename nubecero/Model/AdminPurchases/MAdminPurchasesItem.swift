import Foundation

class MAdminPurchasesItem
{
    var purchaseId:MStore.PurchaseId
    var name:String
    var status:FDatabaseModelPurchase.Status
    let created:TimeInterval
    
    init(purchaseId:MStore.PurchaseId, firebasePurchase:FDatabaseModelPurchase)
    {
        self.purchaseId = purchaseId
        name = firebasePurchase.name
        created = firebasePurchase.created
        status = firebasePurchase.status
    }
}
