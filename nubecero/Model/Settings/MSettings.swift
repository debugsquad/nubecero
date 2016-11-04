import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemSecurity:MSettingsItemSecurity = MSettingsItemSecurity()
        
        items = [
            itemSecurity
        ]
    }
}
