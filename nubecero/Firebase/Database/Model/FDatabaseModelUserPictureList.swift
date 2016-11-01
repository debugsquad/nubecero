import Foundation

class FDatabaseModelPictureList:FDatabaseModel
{
    let items:[String:FDatabaseModelPicture]
    
    required init(snapshot:Any)
    {
        if let rawItems:[String:Any] = snapshot as? [String:Any]
        {
            var items:[String:FDatabaseModelPicture] = [:]
            let keys:[String] = Array(rawItems.keys)
            
            for rawKey:String in keys
            {
                let rawItem:Any = rawItems[rawKey]
                let item:FDatabaseModelPicture = FDatabaseModelPicture(snapshot:rawItem)
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
}
