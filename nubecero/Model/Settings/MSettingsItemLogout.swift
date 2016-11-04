import UIKit

class MSettingsItemLogout:MSettingsItem
{
    private let kCellHeight:CGFloat = 90
    private let kSelectable:Bool = true
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellLogout.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
