import Foundation

class MAdminServer
{
    let items:[MAdminServerItem]
    
    init(server:FDatabaseModelServer)
    {
        let itemFroob:MAdminServerItemFroob = MAdminServerItemFroob(space:server.froobSpace)
        
        items = [
            itemFroob
        ]
    }
}
