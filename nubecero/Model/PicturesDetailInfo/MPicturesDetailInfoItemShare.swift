import UIKit

class MPicturesDetailInfoItemShare:MPicturesDetailInfoItem
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetPicturesShare"))
    }
    
    override func selected(controller:CPictures?)
    {
        controller?.share()
    }
}
