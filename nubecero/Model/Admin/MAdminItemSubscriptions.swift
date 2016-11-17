import Foundation

class MAdminItemSubscriptions:MAdminItem
{
    override init()
    {
        let title:String = NSLocalizedString("MAdminItemSubscriptions_title", comment:"")
        super.init(title:title)
    }
    
    override init(title:String)
    {
        fatalError()
    }
    
    override func controller() -> CController
    {
        let controller:CController = CController()
        
        return controller
    }
}
