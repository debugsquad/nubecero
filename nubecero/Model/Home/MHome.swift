import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemDisk:MHomeItemDisk = MHomeItemDisk()
        let itemSpace:MHomeItemSpace = MHomeItemSpace()
        let itemUpload:MHomeItemUpload = MHomeItemUpload()
        let itemBlankTop:MHomeItemBlank = MHomeItemBlank()
        
        items = [
            itemUpload,
            itemBlankTop,
            itemDisk,
            itemSpace
        ]
    }
}
