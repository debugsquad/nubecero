import UIKit

class MSettingsItemFacebookShare:MSettingsItem
{
    private let kCellHeight:CGFloat = 80
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellFacebookShare.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
