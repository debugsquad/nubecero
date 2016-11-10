import UIKit

class MOnboardItemPrivacy:MOnboardItem
{
    override init()
    {
        let title:String = NSLocalizedString("MOnboardItemPrivacy_title", comment:"")
        
        super.init(image:#imageLiteral(resourceName: "assetOnboardPrivacy"), title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
