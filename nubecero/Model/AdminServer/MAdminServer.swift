import Foundation

class MAdminServer
{
    let items:[MAdminServerItem]
    private weak var itemFroob:MAdminServerItemFroob?
    private weak var itemPlus:MAdminServerItemPlus?
    
    init(server:FDatabaseModelServer)
    {
        let itemFroob:MAdminServerItemFroob = MAdminServerItemFroob(space:server.froobSpace)
        let itemPlus:MAdminServerItemPlus = MAdminServerItemPlus(space:server.plusSpace)
        
        self.itemFroob = itemFroob
        self.itemPlus = itemPlus
        
        items = [
            itemFroob,
            itemPlus
        ]
    }
    
    //MARK: public
    
    func jsonForSave() -> Any?
    {
        guard
            
            let newFroobSpace:Int = itemFroob?.space,
            let newPlusSpace:Int = itemPlus?.space
        
        else
        {
            return nil
        }
            
        let firebaseServer:FDatabaseModelServer = FDatabaseModelServer(
            froobSpace:newFroobSpace,
            plusSpace:newPlusSpace)
        
        let json:Any = firebaseServer.modelJson()
        
        return json
    }
}
