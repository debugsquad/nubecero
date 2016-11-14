import Foundation

class MAdminItemServer:MAdminItem
{
    override init()
    {
        let title:String = NSLocalizedString("MAdminItemServer_title", comment:"")
        super.init(title:title)
    }
    
    override init(title:String)
    {
        fatalError()
    }
    
    override func controller() -> CController
    {
        let controller:CAdminServer = CAdminServer()
        
        return controller
    }
}
