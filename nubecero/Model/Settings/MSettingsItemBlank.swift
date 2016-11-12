import UIKit

class MSettingsItemBlank:MSettingsItem
{
    private let kCellHeight:CGFloat = 15
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellBlank.reusableIdentifier
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
