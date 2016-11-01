import Foundation

class FDatabaseModelPictureList:FDatabaseModel
{
    let items:[FDatabaseModelPicture]
    
    required init(snapshot:Any)
    {
        if let rawItems:[Any] = snapshot as? [Any]
        {
            var items:[FDatabaseModelPicture] = []
            
            for rawItem:Any in rawItems
            {
                let item:FDatabaseModelPicture = FDatabaseModelPicture(snapshot:rawItem)
                items.append(item)
            }
            
            self.items = items
        }
        else
        {
            items = []
        }
        
        super.init()
    }
}
