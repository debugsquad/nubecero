import Foundation

class MPhotos
{
    typealias PhotoId = String
    
    static let sharedInstance:MPhotos = MPhotos()
    let items:[MPhotosItem]
    var deletable:[MPhotosItemPhoto]
    private var photos:[PhotoId:MPhotosItemPhoto]
    
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
