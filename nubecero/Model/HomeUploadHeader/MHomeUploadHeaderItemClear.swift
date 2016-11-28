import UIKit

class MHomeUploadHeaderItemClear:MHomeUploadHeaderItem
{
    override init()
    {
        let title:String = NSLocalizedString("MHomeUploadHeaderItemClear_title", comment:"")
        let color:UIColor = UIColor.red
        
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
