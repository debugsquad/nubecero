import UIKit

class MHomeUploadHeaderItemAlbum:MHomeUploadHeaderItem
{
    override init()
    {
        let title:String = MPhotos.sharedInstance.defaultAlbum.name
        
        super.init(
            image:#imageLiteral(resourceName: "assetHomeAlbum"),
            title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
