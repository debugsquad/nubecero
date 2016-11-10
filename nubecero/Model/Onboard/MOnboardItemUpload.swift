import UIKit

class MOnboardItemUpload:MOnboardItem
{
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
    
    override init()
    {
        let title:String = NSLocalizedString("MOnboardItemUpload_title", comment:"")
        
        super.init(image:#imageLiteral(resourceName: "assetOnboardUpload"), title:title)
    }
}
