import Foundation

class MPicturesDetailInfo
{
    let items:[MPicturesDetailInfoItem]
    
    init()
    {
        let itemShare:MPicturesDetailInfoItemShare = MPicturesDetailInfoItemShare()
        let itemDelete:MPicturesDetailInfoItemDelete = MPicturesDetailInfoItemDelete()
        
        items = [
            itemShare,
            itemDelete
        ]
    }
}
