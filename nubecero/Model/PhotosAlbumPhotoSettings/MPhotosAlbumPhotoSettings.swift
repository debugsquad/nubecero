import Foundation

class MPhotosAlbumPhotoSettings
{
    let items:[MPhotosAlbumPhotoSettingsItem]
    
    init()
    {
        let itemPixels:MPhotosAlbumPhotoSettingsItemPixels = MPhotosAlbumPhotoSettingsItemPixels()
        let itemSize:MPhotosAlbumPhotoSettingsItemSize = MPhotosAlbumPhotoSettingsItemSize()
        let itemTaken:MPhotosAlbumPhotoSettingsItemTaken = MPhotosAlbumPhotoSettingsItemTaken()
        
        items = [
            itemPixels,
            itemSize,
            itemTaken
        ]
    }
}
