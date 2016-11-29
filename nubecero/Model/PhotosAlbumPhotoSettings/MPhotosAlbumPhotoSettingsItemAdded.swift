import UIKit

class MPhotosAlbumPhotoSettingsItemAdded:MPhotosAlbumPhotoSettingsItem
{
    private let kCellHeight:CGFloat = 50
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VPhotosAlbumPhotoSettingsCellAdded.reusableIdentifier
        
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
