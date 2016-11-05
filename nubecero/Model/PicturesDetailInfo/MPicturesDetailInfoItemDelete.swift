import UIKit

class MPicturesDetailInfoItemDelete:MPicturesDetailInfoItem
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetPicturesDelete"))
    }
    
    override func selected(controller:CPictures?)
    {
        FMain.sharedInstance.analytics?.pictureDelete()
        
        controller?.deletePicture()
    }
}
