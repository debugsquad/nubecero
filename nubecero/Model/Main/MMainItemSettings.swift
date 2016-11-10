import UIKit

class MMainItemSettings:MMainItem
{
    private let kIconImage:String = "assetGenericSettings"
    
    override init()
    {
        fatalError()
    }
    
    override init(iconImage:String, index:Int)
    {
        fatalError()
    }
    
    init(index:Int)
    {
        super.init(iconImage:kIconImage, index:index)
    }
    
    override func controller() -> CController
    {
        let controller:CSettings = CSettings()
        
        return controller
    }
}
