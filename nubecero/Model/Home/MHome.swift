import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemUpload:MHomeItemUpload = MHomeItemUpload()
        let itemDisk:MHomeItemDisk = MHomeItemDisk()
        let itemSpaceFree:MHomeItemSpaceFree = MHomeItemSpaceFree()
        let itemSpaceUsed:MHomeItemSpaceUsed = MHomeItemSpaceUsed()
        let itemSpaceTotal:MHomeItemSpaceTotal = MHomeItemSpaceTotal()
        let itemSpacePhotos:MHomeItemSpacePhotos = MHomeItemSpacePhotos()
        
        items = [
            itemUpload,
            itemDisk,
            itemSpaceFree,
            itemSpaceUsed,
            itemSpaceTotal,
            itemSpacePhotos
        ]
    }
}
