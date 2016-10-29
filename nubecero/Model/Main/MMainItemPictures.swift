import UIKit

class MMainItemPictures:MMainItem
{
    private let kIconImage:String = "assetGenericPictures"
    
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