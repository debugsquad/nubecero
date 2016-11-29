import Foundation

class MPhotosAlbumPhotoSettings
{
    let items:[MPhotosAlbumPhotoSettingsItem]
    
    init()
    {
        let itemPixels:MPhotosAlbumPhotoSettingsItemPixels = MPhotosAlbumPhotoSettingsItemPixels()
        
        items = [
            itemPixels
        ]
    }
}
