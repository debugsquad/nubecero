import Foundation

class MAdmin
{
    let items:[MAdminItem]
    
    init()
    {
        let itemServer:MAdminItemServer = MAdminItemServer()
        let itemUsers:MAdminItemUsers = MAdminItemUsers()
        
        items = [
            itemServer,
            itemUsers
        ]
    }
}
