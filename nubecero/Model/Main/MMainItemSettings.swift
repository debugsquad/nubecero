import UIKit

class MMainItemSettings:MMainItem
{
    private let kIconImage:String = "assetGenericSettings"
    
    init(index:Int)
    {
        super.init(iconImage:kIconImage, index:index)
    }
    
    override func controller() -> CController
    {
        let controller:CHome = CHome()
        
        return controller
    }
}
