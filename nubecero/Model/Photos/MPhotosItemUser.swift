import Foundation

class MPhotosItemUser:MPhotosItem
{
    let albumId:MPhotos.AlbumId
    
    init(albumId:MPhotos.AlbumId, firebaseAlbum:FDatabaseModelAlbum)
    {
        self.albumId = albumId
        let name:String = firebaseAlbum.name
        
        super.init(name:name)
    }
    
    override init(name:String)
    {
        fatalError()
    }
    
    override func moveToSelf(path:String)
    {
        FMain.sharedInstance.database.updateChild(
            path:path,
            json:albumId)
    }
}
