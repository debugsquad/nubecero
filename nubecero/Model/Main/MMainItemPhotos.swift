import UIKit

class MMainItemPhotos:MMainItem
{
    private let kIconImage:String = "assetGenericPhotos"
    
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
        let controller:CPhotos = CPhotos()
        
        return controller
    }
}
