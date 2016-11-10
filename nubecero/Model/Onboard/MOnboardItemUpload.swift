import UIKit

class MOnboardItemUpload:MOnboardItem
{
    override init()
    {
        let title:String = NSLocalizedString("MOnboardItemUpload_title", comment:"")
        
        super.init(image:#imageLiteral(resourceName: "assetOnboardUpload"), title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
