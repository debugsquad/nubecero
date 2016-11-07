import Foundation

class FDatabaseModelPictureList:FDatabaseModel
{
    let items:[MPictures.PictureId:FDatabaseModelPicture]
    
    required init(snapshot:Any)
    {
        if let rawItems:[MPictures.PictureId:Any] = snapshot as? [MPictures.PictureId:Any]
        {
            var items:[MPictures.PictureId:FDatabaseModelPicture] = [:]
            let keys:[MPictures.PictureId] = Array(rawItems.keys)
            
            for rawKey:MPictures.PictureId in keys
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
