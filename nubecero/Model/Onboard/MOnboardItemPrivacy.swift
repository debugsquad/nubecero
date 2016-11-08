import UIKit

class MOnboardItemPrivacy:MOnboardItem
{
    override init()
    {
        let title:String = NSLocalizedString("MOnboardItemPrivacy_title", comment:"")
        
        super.init(image:#imageLiteral(resourceName: "assetOnboardAccess"), title:title)
    }
}
