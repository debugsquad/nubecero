import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemAbout:MSettingsItemAbout = MSettingsItemAbout()
        let itemSecurity:MSettingsItemSecurity = MSettingsItemSecurity()
        let itemRate:MSettingsItemRate = MSettingsItemRate()
        let itemLogout:MSettingsItemLogout = MSettingsItemLogout()
        
        items = [
            itemAbout,
            itemSecurity,
            itemRate,
            itemLogout
        ]
    }
}
