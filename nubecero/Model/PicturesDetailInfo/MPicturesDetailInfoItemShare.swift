import UIKit

class MPicturesDetailInfoItemShare:MPicturesDetailInfoItem
{
    override init(image:UIImage)
    {
        fatalError()
    }
    
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetPicturesShare"))
    }
    
    override func selected(controller:CPictures?)
    {
        FMain.sharedInstance.analytics?.pictureShare()
        
        controller?.share()
    }
}
