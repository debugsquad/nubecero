import UIKit

class MSettingsItemAbout:MSettingsItem
{
    private let kCellHeight:CGFloat = 180
    private let kSelectable:Bool = false
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellAbout.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
