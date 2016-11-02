import UIKit

class MPicturesDetailInfoItemData:MPicturesDetailInfoItem
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetPicturesData"))
    }
    
    override func selected(controller:CPictures?)
    {
        controller?.showData()
    }
}
