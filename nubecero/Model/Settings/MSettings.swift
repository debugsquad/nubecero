import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemProfile:MSettingsItemProfile = MSettingsItemProfile()
        let itemSecurity:MSettingsItemSecurity = MSettingsItemSecurity()
        let itemFacebookShare:MSettingsItemFacebookShare = MSettingsItemFacebookShare()
        let itemFacebookInvite:MSettingsItemFacebookInvite = MSettingsItemFacebookInvite()
        let itemLogout:MSettingsItemLogout = MSettingsItemLogout()
        
        items = [
            itemProfile,
            itemSecurity,
            itemFacebookShare,
            itemFacebookInvite,
            itemLogout
        ]
    }
}
