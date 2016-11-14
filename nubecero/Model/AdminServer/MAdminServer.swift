import Foundation

class MAdminServer
{
    let items:[MAdminServerItem]
    private weak var itemFroob:MAdminServerItemFroob?
    
    init(server:FDatabaseModelServer)
    {
        let itemFroob:MAdminServerItemFroob = MAdminServerItemFroob(space:server.froobSpace)
        self.itemFroob = itemFroob
        
        items = [
            itemFroob
        ]
    }
    
    //MARK: public
    
    func jsonForSave() -> Any?
    {
        guard
            
            let newFroobSpace:Int = itemFroob?.space
        
        else
        {
            return nil
        }
            
        let firebaseServer:FDatabaseModelServer = FDatabaseModelServer(
            froobSpace:newFroobSpace)
        
        let json:Any = firebaseServer.modelJson()
        
        return json
    }
}
