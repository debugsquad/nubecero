import UIKit

class MStoreItemAlbums:MStoreItem
{
    private let kStorePurchaseId:MStore.PurchaseId = "iturbide.nubecero.albums"
    
    override init()
    {
        let title:String = NSLocalizedString("MStoreItemAlbums_title", comment:"")
        let descr:String = NSLocalizedString("MStoreItemAlbums_descr", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetPurchaseAlbums")
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr,
            image:image)
    }
    
    override init(purchaseId:MStore.PurchaseId, title:String, descr:String, image:UIImage)
    {
        fatalError()
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings.current?.nubeceroAlbums = true
        DManager.sharedInstance.save()
    }
    
    override func validatePurchase() -> Bool
    {
        var isPurchased:Bool = false
        
        guard
        
            let albums:Bool = MSession.sharedInstance.settings.current?.nubeceroAlbums
        
        else
        {
            return isPurchased
        }
        
        isPurchased = albums
        
        return isPurchased
    }
}
