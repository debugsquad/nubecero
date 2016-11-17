import UIKit

class MStoreItemAlbums:MStoreItem
{
    private let kStorePurchaseId:MStore.PurchaseId = "iturbide.nubercero.albums"
    
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
    
    init(purchaseId:MStore.PurchaseId, title:String, descr:String, image:UIImage)
    {
        fatalError()
    }
}