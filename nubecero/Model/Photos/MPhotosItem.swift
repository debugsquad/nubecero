import Foundation

class MPhotosItem
{
    let name:String
    private(set) var references:[MPhotosItemPhotoReference]
    private(set) var kiloBytes:Int
    private let kZero:Int = 0
    
    init(name:String)
    {
        self.name = name
        references = []
        kiloBytes = kZero
    }
    
    //MARK: public
    
    func clearReferences()
    {
        kiloBytes = kZero
        references = []
    }
    
    func addReference(reference:MPhotosItemPhotoReference, kiloBytes:Int)
    {
        references.append(reference)
        self.kiloBytes += kiloBytes
    }
    
    func sortPhotos()
    {
        references.sort
        { (referenceA:MPhotosItemPhotoReference, referenceB:MPhotosItemPhotoReference) -> Bool in
            
            let createdA:TimeInterval = referenceA.created
            let createdB:TimeInterval = referenceB.created
            
            return createdA > createdB
        }
    }
}
