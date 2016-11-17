import Foundation

class MAdminPurchasesItem
{
    var purchaseId:MStore.PurchaseId
    var status:FDatabaseModelPurchase.Status
    let firebasePurchaseId:FDatabaseModelPurchase.PurchaseId
    let created:TimeInterval
    let originalStatus:FDatabaseModelPurchase.Status
    
    init(firebasePurchaseId:FDatabaseModelPurchase.PurchaseId, firebasePurchase:FDatabaseModelPurchase)
    {
        self.firebasePurchaseId = firebasePurchaseId
        purchaseId = firebasePurchase.purchaseId
        created = firebasePurchase.created
        status = firebasePurchase.status
        originalStatus = status
    }
}
