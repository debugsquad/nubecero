import Foundation

class MAdminItemServer:MAdminItem
{
    override init()
    {
        let title:String = NSLocalizedString("", comment:"")
        super.init(title:title)
    }
    
    override init(title:String)
    {
        fatalError()
    }
    
    override func controller() -> CController
    {
        let controller:CController = CController()
        
        return CController()
    }
}
