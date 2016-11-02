import UIKit

class MPicturesDetailInfoItemDelete:MPicturesDetailInfoItem
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetPicturesDelete"))
    }
    
    override func selected(controller:CPictures?)
    {
        controller?.deletePicture()
    }
}
