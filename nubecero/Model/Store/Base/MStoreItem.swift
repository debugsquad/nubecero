import UIKit
import StoreKit

class MStoreItem
{
    let purchaseId:MStore.PurchaseId
    let title:String
    let descr:String
    let image:UIImage
    var skProduct:SKProduct?
    private(set) var price:String?
    private(set) var status:MStoreItemStatus?
    
    init(purchaseId:MStore.PurchaseId, title:String, descr:String, image:UIImage)
    {
        self.purchaseId = purchaseId
        self.title = title
        self.descr = descr
        self.image = image
        status = MStoreItemStatusNotAvailable()
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func purchaseAction()
    {
        fatalError()
    }
    
    func validatePurchase() -> Bool
    {
        fatalError()
    }
    
    func foundPurchase(price:String)
    {
        self.price = price
        statusNew()
    }
    
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
