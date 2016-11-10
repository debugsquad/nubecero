import UIKit

class MMainItemHome:MMainItem
{
    private let kIconImage:String = "assetGenericHome"
    
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
        let controller:CHome = CHome(askAuth:false)
        
        return controller
    }
}
