import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemUpload:MHomeItemUpload = MHomeItemUpload()
        let itemBlankTop:MHomeItemBlank = MHomeItemBlank()
        let itemDisk:MHomeItemDisk = MHomeItemDisk()
        let itemSpaceFree:MHomeItemSpaceFree = MHomeItemSpaceFree()
        let itemSpaceUsed:MHomeItemSpaceUsed = MHomeItemSpaceUsed()
        let itemSpaceTotal:MHomeItemSpaceTotal = MHomeItemSpaceTotal()
        
        items = [
            itemUpload,
            itemBlankTop,
            itemDisk,
            itemSpaceFree,
            itemSpaceUsed,
            itemSpaceTotal
        ]
    }
}
