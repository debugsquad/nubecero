import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemAbout:MSettingsItemAbout = MSettingsItemAbout()
        let itemAccount:MSettingsItemAccount = MSettingsItemAccount()
        let itemShare:MSettingsItemShare = MSettingsItemShare()
        let itemSecurity:MSettingsItemSecurity = MSettingsItemSecurity()
        let itemRate:MSettingsItemRate = MSettingsItemRate()
        let itemLogout:MSettingsItemLogout = MSettingsItemLogout()
        let itemBlankTop:MSettingsItemBlank = MSettingsItemBlank()
        let itemBlankMiddle:MSettingsItemBlank = MSettingsItemBlank()
        let itemBlankBottom:MSettingsItemBlank = MSettingsItemBlank()
        
        items = [
            itemAbout,
            itemAccount,
            itemBlankTop,
            itemSecurity,
            itemBlankMiddle,
            itemShare,
            itemRate,
            itemBlankBottom,
            itemLogout
        ]
    }
}
