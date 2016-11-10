import UIKit

class MMainItemSettings:MMainItem
{
    private let kIconImage:String = "assetGenericSettings"
    
    init(index:Int)
    {
        super.init(iconImage:kIconImage, index:index)
    }
    
    override init()
    {
        fatalError()
    }
    
    override init(iconImage:String, index:Int)
    {
        fatalError()
    }
    
    override func controller() -> CController
    {
        let controller:CSettings = CSettings()
        
        return controller
    }
}
