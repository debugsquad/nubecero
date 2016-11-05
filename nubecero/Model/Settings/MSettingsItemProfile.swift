import UIKit

class MSettingsItemProfile:MSettingsItem
{
    private let kCellHeight:CGFloat = 200
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellProfile.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
