import UIKit

class MSettingsItemLogout:MSettingsItem
{
    private let kCellHeight:CGFloat = 50
    private let kSelectable:Bool = true
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellLogout.reusableIdentifier
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
        FMain.sharedInstance.analytics?.logout()
        
        controller.logOut()
    }
}
