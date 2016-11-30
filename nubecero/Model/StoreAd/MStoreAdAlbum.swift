import UIKit

class MStoreAdAlbum:MStoreAd
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetPurchaseAlbums")
        let title:String = NSLocalizedString("MStoreAdAlbum_title", comment:"")
        let descr:String = NSLocalizedString("MStoreAdAlbum_descr", comment:"")
        
        super.init(
            image:image,
            title:title,
            descr:descr)
    }
    
    override init(image:UIImage, title:String, descr:String)
    {
        fatalError()
    }
}
