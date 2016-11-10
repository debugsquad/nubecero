import UIKit

class MOnboardItemFree:MOnboardItem
{
    override init()
    {
        let title:String = NSLocalizedString("MOnboardItemFree_title", comment:"")
        
        super.init(image:#imageLiteral(resourceName: "assetOnboardFree"), title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
