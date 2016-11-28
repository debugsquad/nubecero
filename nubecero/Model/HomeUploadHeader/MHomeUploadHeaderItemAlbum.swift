import UIKit

class MHomeUploadHeaderItemAlbum:MHomeUploadHeaderItem
{
    override init()
    {
        let title:String = MPhotos.sharedInstance.defaultAlbum.name
        let color:UIColor = UIColor.complement
        
        super.init(
            image:#imageLiteral(resourceName: "assetHomeAlbum"),
            title:title,
            color:color)
    }
    
    override init(image:UIImage, title:String, color:UIColor)
    {
        fatalError()
    }
}
