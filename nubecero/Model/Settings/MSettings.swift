import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemProfile:MSettingsItemProfile = MSettingsItemProfile()
        let itemFacebookShare:MSettingsItemFacebookShare = MSettingsItemFacebookShare()
        let itemSecurity:MSettingsItemSecurity = MSettingsItemSecurity()
        let itemLogout:MSettingsItemLogout = MSettingsItemLogout()
        
        items = [
            itemProfile,
            itemSecurity,
            itemFacebookShare,
            itemLogout
        ]
    }
}
