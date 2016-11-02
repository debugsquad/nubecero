import Foundation

class MPicturesDetailInfo
{
    let items:[MPicturesDetailInfoItem]
    
    init()
    {
        let itemDelete:MPicturesDetailInfoItemDelete = MPicturesDetailInfoItemDelete()
        
        items = [
            itemDelete
        ]
    }
}
