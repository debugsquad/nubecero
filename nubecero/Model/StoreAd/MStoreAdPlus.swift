import UIKit

class MStoreAdPlus:MStoreAd
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetPurchasePlus")
        let title:String = NSLocalizedString("MStoreAdPlus_title", comment:"")
        let descr:String = NSLocalizedString("MStoreAdPlus_descr", comment:"")
        
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
