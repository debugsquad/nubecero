import Foundation

class MAdminItemUsers:MAdminItem
{
    override init()
    {
        let title:String = NSLocalizedString("MAdminItemUsers_title", comment:"")
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
