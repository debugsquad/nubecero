import Foundation

class MHomeUploadHeader
{
    let items:[MHomeUploadHeaderItem]
    
    init()
    {
        let itemAlbum:MHomeUploadHeaderItemAlbum = MHomeUploadHeaderItemAlbum()
        let itemClear:MHomeUploadHeaderItemClear = MHomeUploadHeaderItemClear()
        
        items = [
            itemClear,
            itemAlbum
        ]
    }
}
