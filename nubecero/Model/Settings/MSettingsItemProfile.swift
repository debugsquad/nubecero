import UIKit

class MSettingsItemProfile:MSettingsItem
{
    private let kCellHeight:CGFloat = 200
    private let kSelectable:Bool = true
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellLogout.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override func selected(controller:CSettings)
    {
        controller.logOut()
    }
}
