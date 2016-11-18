import Foundation

class MPhotos
{
    typealias PhotoId = String
    
    static let sharedInstance:MPhotos = MPhotos()
    let items:[MPhotosItem]
    var deletable:[MPicturesItem]
    private var items:[PictureId:MPicturesItem]
    
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
