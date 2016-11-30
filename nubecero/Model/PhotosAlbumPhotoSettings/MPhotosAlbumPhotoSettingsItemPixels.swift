import UIKit

class MPhotosAlbumPhotoSettingsItemPixels:MPhotosAlbumPhotoSettingsItem
{
    private let kCellHeight:CGFloat = 150
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VPhotosAlbumPhotoSettingsCellPixels.reusableIdentifier
        
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
