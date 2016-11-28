import Foundation

class MHomeUploadHeader
{
    let items:[MHomeUploadHeaderItem]
    
    init()
    {
        let itemAlbum:MHomeUploadHeaderItemAlbum = MHomeUploadHeaderItemAlbum()
        let itemSelectAll:MHomeUploadHeaderItemSelectAll = MHomeUploadHeaderItemSelectAll()
        let itemClear:MHomeUploadHeaderItemClear = MHomeUploadHeaderItemClear()
        
        items = [
            itemClear,
            itemSelectAll,
            itemAlbum
        ]
    }
}
