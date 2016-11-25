import UIKit

class MPhotosAlbumPhotoItemShare:MPhotosAlbumPhotoItem
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetPhotosShare"))
    }
    
    override init(image:UIImage)
    {
        fatalError()
    }
    
    override func selected(controller:CPhotosAlbumPhoto)
    {
        controller.share()
    }
}
