import UIKit

class MPhotosAlbumPhotoItemSettings:MPhotosAlbumPhotoItem
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetPhotoSettings"))
    }
    
    override init(image:UIImage)
    {
        fatalError()
    }
}
