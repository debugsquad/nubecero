import Foundation

class MPhotosItemReference
{
    let albumId:MPhotos.AlbumId
    let created:TimeInterval
    
    init(albumId:MPhotos.AlbumId, created:TimeInterval)
    {
        self.albumId = albumId
        self.created = created
    }
}
