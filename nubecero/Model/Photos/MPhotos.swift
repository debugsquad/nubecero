import Foundation

class MPhotos
{
    let items:[MPhotosItem]
    
    init()
    {
        let itemDefault:MPhotosItem = MPhotosItem(name:"default")
        let itemWedding:MPhotosItem = MPhotosItem(name:"wedding")
        
        items = [
            itemDefault,
            itemWedding
        ]
    }
}
