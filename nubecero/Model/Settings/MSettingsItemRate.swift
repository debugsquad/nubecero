import UIKit

class MSettingsItemRate:MSettingsItem
{
    private let kCellHeight:CGFloat = 50
    private let kSelectable:Bool = true
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellRate.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
    
    override func selected(controller:CSettings)
    {
        FMain.sharedInstance.analytics?.rate()
        
        controller.rate()
    }
}
