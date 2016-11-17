import Foundation

class MPhotosItem
{
    let name:String
    let references:[MPhotos.PhotoId]
    var kiloBytes:Int
    
    init(name:String, references:[MPhotos.PhotoId])
    {
        self.name = name
        self.references = references
        kiloBytes = 123456789
    }
}
