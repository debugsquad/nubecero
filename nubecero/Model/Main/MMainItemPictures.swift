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
        let controller:CPictures = CPictures()
        
        return controller
    }
}
