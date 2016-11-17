import Foundation

class MAdminItemPurchases:MAdminItem
{
    override init()
    {
        let title:String = NSLocalizedString("MAdminItemPurchases_title", comment:"")
        super.init(title:title)
    }
    
    override init(title:String)
    {
        fatalError()
    }
    
    override func controller() -> CController
    {
        let controller:CAdminPurchases = CAdminPurchases()
        
        return controller
    }
}
