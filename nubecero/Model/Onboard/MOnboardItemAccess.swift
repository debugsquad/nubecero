import UIKit

class MOnboardItemAccess:MOnboardItem
{
    override init()
    {
        let title:String = NSLocalizedString("MOnboardItemAccess_title", comment:"")
        
        super.init(image:#imageLiteral(resourceName: "assetOnboardAccess"), title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
