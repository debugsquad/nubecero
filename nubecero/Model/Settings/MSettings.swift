import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemProfile:MSettingsItemProfile = MSettingsItemProfile()
        let itemSecurity:MSettingsItemSecurity = MSettingsItemSecurity()
        let itemLogout:MSettingsItemLogout = MSettingsItemLogout()
        
        items = [
            itemProfile,
            itemSecurity,
            itemLogout
        ]
    }
}
