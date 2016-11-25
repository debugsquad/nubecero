import UIKit

class MPhotosAlbumPhotoItemSettings:MPhotosAlbumPhotoItem
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetPhotosSettings"))
    }
    
    override init(image:UIImage)
    {
        fatalError()
    }
    
    override func selected(controller:CPhotosAlbumPhoto)
    {
        controller.settings()
    }
}
