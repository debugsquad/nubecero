import Foundation

class MPhotosItem
{
    let albumId:MPhotos.AlbumId
    let name:String
    let references:[MPhotos.PhotoId]
    var kiloBytes:Int
    private let kZero:Int = 0
    
    init(albumId:MPhotos.AlbumId, firebaseAlbum:FDatabaseModelAlbum)
    {
        self.albumId = albumId
        name = firebaseAlbum.name
        references = []
        kiloBytes = kZero
    }
}
