import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemDisk:MHomeItemDisk = MHomeItemDisk()
        let itemUpload:MHomeItemUpload = MHomeItemUpload()
        
        items = [
            itemDisk,
            itemUpload
        ]
    }
}
