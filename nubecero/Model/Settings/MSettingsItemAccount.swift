import UIKit

class MSettingsItemAccount:MSettingsItem
{
    private let kCellHeight:CGFloat = 45
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellAccount.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
}
