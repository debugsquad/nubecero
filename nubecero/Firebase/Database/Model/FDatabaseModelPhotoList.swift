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
                guard
                    
                    let rawItem:Any = rawItems[rawKey]
                
                else
                {
                    continue
                }
                
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
    
    override func modelJson() -> Any
    {
        let keys:[MPhotos.PhotoId] = Array(items.keys)
        var json:[String:Any] = [:]
        
        for key:MPhotos.PhotoId in keys
        {
            guard
            
                let photo:FDatabaseModelPhoto = items[key]
            
            else
            {
                continue
            }
            
            let jsonPhoto:Any = photo.modelJson()
            json[key] = jsonPhoto
        }
        
        return json
    }
}
