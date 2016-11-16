import Foundation
import StoreKit

class MStoreItem
{
    enum Perk:String
    {
        case unknown
        case plus = "iturbide.nubecero.nubeceroplus"
    }
    
    let purchaseId:MStore.PurchaseId
    let purchaseTitle:String
    let purchaseDescription:String
    let purchaseAsset:String
    let perk:Perk
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
        purchaseAsset = "assetPurchase.\(purchaseId)"
        
        if let perk:Perk = Perk(rawValue:purchaseId)
        {
            self.perk = perk
        }
        else
        {
            self.perk = Perk.unknown
        }
        
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
