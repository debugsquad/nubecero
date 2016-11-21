import Foundation

class MPhotosItemReference
{
    let albumId:MPhotos.AlbumId
    let name:String
    
    init(albumId:MPhotos.AlbumId, name:String)
    {
        self.albumId = albumId
        self.name = name
    }
}
