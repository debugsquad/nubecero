import UIKit

class MSettingsItemRate:MSettingsItem
{
    private let kCellHeight:CGFloat = 60
    private let kSelectable:Bool = true
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellRate.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override func selected(controller:CSettings)
    {
        FMain.sharedInstance.analytics?.rate()
        
        controller.rate()
    }
}
