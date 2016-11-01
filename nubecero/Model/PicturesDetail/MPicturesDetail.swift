import Foundation

class MPicturesDetail
{
    let items:[MPicturesDetailItem]
    let itemsWeight:Int
    
    init()
    {
        var itemsWeight:Int = 0
        
        let itemImage:MPicturesDetailItemImage = MPicturesDetailItemImage()
        let itemInfo:MPicturesDetailItemInfo = MPicturesDetailItemInfo()
        
        itemsWeight += itemImage.sizeWeight
        itemsWeight += itemInfo.sizeWeight
        
        items = [
            itemImage,
            itemInfo
        ]
        
        self.itemsWeight = itemsWeight
    }
}
