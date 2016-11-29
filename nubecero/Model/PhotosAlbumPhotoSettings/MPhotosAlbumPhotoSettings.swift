import Foundation

class MPhotosAlbumPhotoSettings
{
    let items:[MPhotosAlbumPhotoSettingsItem]
    
    init()
    {
        let itemPixels:MPhotosAlbumPhotoSettingsItemPixels = MPhotosAlbumPhotoSettingsItemPixels()
        let itemSize:MPhotosAlbumPhotoSettingsItemSize = MPhotosAlbumPhotoSettingsItemSize()
        let itemTaken:MPhotosAlbumPhotoSettingsItemTaken = MPhotosAlbumPhotoSettingsItemTaken()
        let itemAdded:MPhotosAlbumPhotoSettingsItemAdded = MPhotosAlbumPhotoSettingsItemAdded()
        
        items = [
            itemPixels,
            itemSize,
            itemTaken,
            itemAdded
        ]
    }
}
