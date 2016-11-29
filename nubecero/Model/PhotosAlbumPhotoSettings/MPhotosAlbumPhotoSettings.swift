import Foundation

class MPhotosAlbumPhotoSettings
{
    let items:[MPhotosAlbumPhotoSettingsItem]
    
    init()
    {
        let itemPixels:MPhotosAlbumPhotoSettingsItemPixels = MPhotosAlbumPhotoSettingsItemPixels()
        let itemSize:MPhotosAlbumPhotoSettingsItemSize = MPhotosAlbumPhotoSettingsItemSize()
        
        items = [
            itemPixels,
            itemSize
        ]
    }
}
