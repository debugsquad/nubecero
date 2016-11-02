import Foundation

class MPicturesDetailInfo
{
    let items:[MPicturesDetailInfoItem]
    
    init()
    {
        let itemShare:MPicturesDetailInfoItemShare = MPicturesDetailInfoItemShare()
        let itemData:MPicturesDetailInfoItemData = MPicturesDetailInfoItemData()
        let itemDelete:MPicturesDetailInfoItemDelete = MPicturesDetailInfoItemDelete()
        
        items = [
            itemData,
            itemShare,
            itemDelete
        ]
    }
}
