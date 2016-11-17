import Foundation

class MPhotos
{
    typealias PhotoId = String
    
    static let sharedInstance:MPhotos = MPhotos()
    let items:[MPhotosItem]
    
    init()
    {
        let itemDefault:MPhotosItem = MPhotosItem(name:"default", references:["","",""])
        let itemWedding:MPhotosItem = MPhotosItem(name:"Josh' wedding", references:[])
        
        items = [
            itemDefault,
            itemWedding
        ]
    }
}
