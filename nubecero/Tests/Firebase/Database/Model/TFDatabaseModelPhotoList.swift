import XCTest
@testable import nubecero

class TFDatabaseModelPhotoList:XCTestCase
{
    private let kPictureIdA:MPhotos.PhotoId = "hello world"
    private let kPictureIdB:MPhotos.PhotoId = "nubecero"
    private let kPictureIdC:MPhotos.PhotoId = "swift"
    private let kEmpty:Any = ""
    private let kCreated:TimeInterval = 123456
    private let kNoPictures:Int = 0
    
    func testInitSnapshot()
    {
        let keyCreated:String = FDatabaseModelPhoto.Property.created.rawValue
        
        let snapshot:[MPhotos.PhotoId:Any] = [
            kPictureIdA:[
                keyCreated:kCreated
            ]
        ]
        
        let model:FDatabaseModelPhotoList = FDatabaseModelPhotoList(
            snapshot:snapshot)
        
        XCTAssertNotNil(
            model.items.first,
            "Error parsing first item")
        
        XCTAssertNotNil(
            model.items[kPictureIdA],
            "Error parsing first item")
        
        XCTAssertEqual(
            model.items[kPictureIdA]!.created,
            kCreated,
            "Error parsing picture properties")
    }
}
