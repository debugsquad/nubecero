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
    
    func testInitSnapshotEmpty()
    {
        let snapshot:[MPhotos.PhotoId:Any] = [
            kPictureIdA:kEmpty,
            kPictureIdB:kEmpty,
            kPictureIdC:kEmpty
        ]
        
        let model:FDatabaseModelPhotoList = FDatabaseModelPhotoList(
            snapshot:snapshot)
        
        let snapshotKeys:[MPhotos.PhotoId] = Array(snapshot.keys)
        let countPictures:Int = model.items.count
        let countSnapshotKeys:Int = snapshotKeys.count
        
        XCTAssertEqual(
            countSnapshotKeys,
            countPictures,
            "Not the same amount of items parsed")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:Any = kEmpty
        
        let model:FDatabaseModelPhotoList = FDatabaseModelPhotoList(
            snapshot:snapshot)
        
        let countPictures:Int = model.items.count
        
        XCTAssertEqual(
            kNoPictures,
            countPictures,
            "Photos should be empty")
    }
}
