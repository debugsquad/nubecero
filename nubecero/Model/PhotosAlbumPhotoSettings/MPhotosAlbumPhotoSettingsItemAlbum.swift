import UIKit

class MPhotosAlbumPhotoSettingsItemAlbum:MPhotosAlbumPhotoSettingsItem
{
    private let kCellHeight:CGFloat = 60
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VPhotosAlbumPhotoSettingsCellAlbum.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override init(
        reusableIdentifier:String,
        cellHeight:CGFloat,
        selectable:Bool)
    {
        fatalError()
    }
}
