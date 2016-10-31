import Foundation
import FirebaseStorage

class FStorage
{
    enum Parent:String
    {
        case user = "user"
    }
    
    private let reference:FIRStorageReference
    
    init()
    {
        reference = FIRStorage.storage().reference()
    }
    
    //MARK: public
    
    func saveData(path:String, data:Data, completionHandler:@escaping((String?) -> ()))
    {
        let childReference:FIRStorageReference = reference.child(path)
        childReference.put(
            data,
            metadata:nil)
        { (metaData, error) in
            
            let errorString:String? = error?.localizedDescription
            completionHandler(errorString)
        }
    }
}
