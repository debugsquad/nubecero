import Foundation

class MAdmin
{
    let items:[MAdminItem]
    
    init()
    {
        let itemServer:MAdminItemServer = MAdminItemServer()
        let itemPurchases:MAdminItemPurchases = MAdminItemPurchases()
        let itemUsers:MAdminItemUsers = MAdminItemUsers()
        let itemSubscriptions:MAdminItemSubscriptions = MAdminItemSubscriptions()
        
        items = [
            itemServer,
            itemPurchases,
            itemUsers,
            itemSubscriptions
        ]
    }
}
