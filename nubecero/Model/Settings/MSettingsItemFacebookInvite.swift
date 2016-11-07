import UIKit

class MSettingsItemFacebookInvite:MSettingsItem
{
    private let kCellHeight:CGFloat = 60
    private let kSelectable:Bool = true
    
    override init()
    {
        let reusableIdentifier:String = VSettingsCellFacebookInvite.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override func selected(controller:CSettings)
    {
        FMain.sharedInstance.analytics?.invite()
        
        controller.facebookInvite()
    }
}