import Foundation
import StoreKit

class MStoreItem
{
    let purchaseId:MStore.PurchaseId
    let purchaseTitle:String
    let purchaseDescription:String
    var skProduct:SKProduct?
    var price:String?
    var status:MStoreItemStatus?
    
    init(firebasePurchase:FDatabaseModelPurchase)
    {
        purchaseId = firebasePurchase.purchaseId
        let titleString:String = "\(purchaseId)_title"
        let descriptionString:String = "\(purchaseId)_descr"
        purchaseTitle = NSLocalizedString(titleString, comment:"")
        purchaseDescription = NSLocalizedString(descriptionString, comment:"")
        statusNew()
    }
    
    //MARK: public
    
    func statusNew()
    {
        status = MStoreItemStatusNew()
    }
    
    func statusDeferred()
    {
        status = MStoreItemStatusDeferred()
    }
    
    func statusPurchasing()
    {
        status = MStoreItemStatusPurchasing()
    }
    
    func statusPurchased()
    {
        status = MStoreItemStatusPurchased()
    }
}
