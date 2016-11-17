import Foundation

class FDatabaseModelUserList:FDatabaseModel
{
    let items:[MSession.UserId:FDatabaseModelUser]
    
    required init(snapshot:Any)
    {
        if let rawItems:[MSession.UserId:Any] = snapshot as? [MSession.UserId:Any]
        {
            var items:[MSession.UserId:FDatabaseModelUser] = [:]
            let keys:[MSession.UserId] = Array(rawItems.keys)
            
            for rawKey:MSession.UserId in keys
            {
                let rawItem:Any = rawItems[rawKey]
                let item:FDatabaseModelUser = FDatabaseModelUser(snapshot:rawItem)
                items[rawKey] = item
            }
            
            self.items = items
        }
        else
        {
            items = [:]
        }
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
}
