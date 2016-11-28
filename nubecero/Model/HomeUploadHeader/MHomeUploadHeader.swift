import Foundation

class MHomeUploadHeader
{
    let items:[MHomeUploadHeaderItem]
    
    init()
    {
        let itemAlbum:MHomeUploadHeaderItemAlbum = MHomeUploadHeaderItemAlbum()
        
        items = [
            itemAlbum
        ]
    }
}
