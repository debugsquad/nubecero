import Foundation

class MOnboard
{
    let items:[MOnboardItem]
    
    init()
    {
        let itemUpload:MOnboardItemUpload = MOnboardItemUpload()
        
        items = [
            itemUpload
        ]
    }
}
