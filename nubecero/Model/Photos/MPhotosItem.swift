import Foundation

class MPhotosItem
{
    let name:String
    var references:[MPhotosItemPhotoReference]
    var kiloBytes:Int
    private let kZero:Int = 0
    
    init(name:String)
    {
        self.name = name
        references = []
        kiloBytes = kZero
    }
    
    //MARK: public
    
    func sortPhotos()
    {
        references.sort
        { (referenceA, referenceB) -> Bool in
            
            let createdA:TimeInterval = referenceA.created
            let createdB:TimeInterval = referenceB.created
            
            return createdA > createdB
        }
    }
}
