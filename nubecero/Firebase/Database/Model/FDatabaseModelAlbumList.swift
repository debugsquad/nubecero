import Foundation

class FDatabaseModelAlbumList:FDatabaseModel
{
    let items:[MPhotos.AlbumId:FDatabaseModelAlbum]
    
    required init(snapshot:Any)
    {
        if let rawItems:[MPhotos.AlbumId:Any] = snapshot as? [MPhotos.AlbumId:Any]
        {
            var items:[MPhotos.AlbumId:FDatabaseModelAlbum] = [:]
            let keys:[MPhotos.AlbumId] = Array(rawItems.keys)
            
            for rawKey:MPhotos.AlbumId in keys
            {
                guard
                    
                    let rawItem:Any = rawItems[rawKey]
                
                else
                {
                    continue
                }
                
                let item:FDatabaseModelAlbum = FDatabaseModelAlbum(snapshot:rawItem)
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
