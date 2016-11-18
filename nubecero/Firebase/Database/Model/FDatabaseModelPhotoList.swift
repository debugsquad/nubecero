import Foundation

class FDatabaseModelPhotoList:FDatabaseModel
{
    let items:[MPhotos.PhotoId:FDatabaseModelPhoto]
    
    required init(snapshot:Any)
    {
        if let rawItems:[MPhotos.PhotoId:Any] = snapshot as? [MPhotos.PhotoId:Any]
        {
            var items:[MPhotos.PhotoId:FDatabaseModelPhoto] = [:]
            let keys:[MPhotos.PhotoId] = Array(rawItems.keys)
            
            for rawKey:MPhotos.PhotoId in keys
            {
                let rawItem:Any = rawItems[rawKey]
                let item:FDatabaseModelPhoto = FDatabaseModelPhoto(snapshot:rawItem)
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
