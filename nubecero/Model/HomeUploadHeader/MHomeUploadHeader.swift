import Foundation

class MHomeUploadHeader
{
    let items:[MHomeUploadHeaderItem]
    
    init(controller:CHomeUpload)
    {
        let itemAlbum:MHomeUploadHeaderItemAlbum = MHomeUploadHeaderItemAlbum(controller:controller)
        let itemSelectAll:MHomeUploadHeaderItemSelectAll = MHomeUploadHeaderItemSelectAll()
        let itemClear:MHomeUploadHeaderItemClear = MHomeUploadHeaderItemClear()
        
        items = [
            itemClear,
            itemSelectAll,
            itemAlbum
        ]
    }
}
