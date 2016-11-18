import Foundation

class FDatabaseModelPhotoList:FDatabaseModel
{
    let items:[MPhotos.PhotoId:FDatabaseModelPhoto]
    
    required init(snapshot:Any)
    {
        if let rawItems:[MPhotos.PhotoId:Any] = snapshot as? [MPhotos.PhotoId:Any]
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
    
    override init()
    {
        fatalError()
    }
}
