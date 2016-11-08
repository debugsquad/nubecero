import UIKit

class MSettingsItemAbout:MSettingsItem
{
    private let kCellHeight:CGFloat = 250
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellAbout.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
