import Foundation

class MAdmin
{
    let items:[MAdminItem]
    
    init()
    {
        let itemServer:MAdminItemServer = MAdminItemServer()
        let itemPurchases:MAdminItemPurchases = MAdminItemPurchases()
        let itemUsers:MAdminItemUsers = MAdminItemUsers()
        
        items = [
            itemServer,
            itemPurchases,
            itemUsers
        ]
    }
}
