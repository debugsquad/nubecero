import Foundation

class MOnboard
{
    let items:[MOnboardItem]
    
    init()
    {
        let itemUpload:MOnboardItemUpload = MOnboardItemUpload()
        let itemAccess:MOnboardItemAccess = MOnboardItemAccess()
        let itemFree:MOnboardItemFree = MOnboardItemFree()
        let itemPrivacy:MOnboardItemPrivacy = MOnboardItemPrivacy()
        
        items = [
            itemUpload,
            itemAccess,
            itemFree,
            itemPrivacy
        ]
    }
}
