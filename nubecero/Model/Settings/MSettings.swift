import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemSecurity:MSettingsItemSecurity = MSettingsItemSecurity()
        let itemLogout:MSettingsItemLogout = MSettingsItemLogout()
        
        items = [
            itemSecurity,
            itemLogout
        ]
    }
}
