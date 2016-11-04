import UIKit

class MSettingsItemSecurity:MSettingsItem
{
    private let kCellHeight:CGFloat = 100
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellSecurity.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
