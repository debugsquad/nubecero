import UIKit

class MMainItemAdmin:MMainItem
{
    private let kIconImage:String = "assetGenericStore"
    
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
        let controller:CStore = CStore()
        
        return controller
    }
}
