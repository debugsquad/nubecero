import UIKit

class MOnboardItemFree:MOnboardItem
{
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
    
    override init()
    {
        let title:String = NSLocalizedString("MOnboardItemFree_title", comment:"")
        
        super.init(image:#imageLiteral(resourceName: "assetOnboardFree"), title:title)
    }
}
