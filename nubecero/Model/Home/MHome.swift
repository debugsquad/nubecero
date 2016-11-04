import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemDisk:MHomeItemDisk = MHomeItemDisk()
        let itemSpace:MHomeItemSpace = MHomeItemSpace()
        let itemUpload:MHomeItemUpload = MHomeItemUpload()
        
        items = [
            itemUpload,
            itemDisk,
            itemSpace
        ]
    }
}
