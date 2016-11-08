import Foundation

class MOnboard
{
    let items:[MOnboardItem]
    
    init()
    {
        let itemUpload:MOnboardItemUpload = MOnboardItemUpload()
        let itemAccess:MOnboardItemAccess = MOnboardItemAccess()
        
        items = [
            itemUpload,
            itemAccess
        ]
    }
}
