import UIKit

class MSettingsItemSecurity:MSettingsItem
{
    private let kCellHeight:CGFloat = 80
    private let kSelectable:Bool = false
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellSecurity.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
