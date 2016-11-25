import Foundation

class MPhotosAlbumPhoto
{
    let items:[MPhotosAlbumPhotoItem]
    
    init()
    {
        let itemSettings:MPhotosAlbumPhotoItemSettings = MPhotosAlbumPhotoItemSettings()
        let itemShare:MPhotosAlbumPhotoItemShare = MPhotosAlbumPhotoItemShare()
        
        items = [
            itemSettings,
            itemShare
        ]
    }
}
