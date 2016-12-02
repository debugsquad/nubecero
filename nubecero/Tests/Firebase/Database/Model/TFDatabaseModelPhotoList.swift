import XCTest
@testable import nubecero

class TFDatabaseModelPhotoList:XCTestCase
{
    private let kPhotoIdA:MPhotos.PhotoId = "hello world"
    private let kPhotoIdB:MPhotos.PhotoId = "nubecero"
    private let kPhotoIdC:MPhotos.PhotoId = "swift"
    private let kEmpty:Any = ""
    private let kCreated:TimeInterval = 123456
    private let kNoPhotos:Int = 0
    
    func testInitSnapshot()
    {
        let keyCreated:String = FDatabaseModelPhoto.Property.created.rawValue
        
        let snapshot:[MPhotos.PhotoId:Any] = [
            kPhotoIdA:[
                keyCreated:kCreated
            ]
        ]
        
        let model:FDatabaseModelPhotoList = FDatabaseModelPhotoList(
            snapshot:snapshot)
        
        XCTAssertNotNil(
            model.items.first,
            "Error parsing first item")
        
        XCTAssertNotNil(
            model.items[kPhotoIdA],
            "Error parsing first item")
        
        XCTAssertEqual(
            model.items[kPhotoIdA]!.created,
            kCreated,
            "Error parsing photo properties")
    }
    
    func testInitSnapshotEmpty()
    {
        let snapshot:[MPhotos.PhotoId:Any] = [
            kPhotoIdA:kEmpty,
            kPhotoIdB:kEmpty,
            kPhotoIdC:kEmpty
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
        
        let countPhotos:Int = model.items.count
        
        XCTAssertEqual(
            kNoPhotos,
            countPhotos,
            "Photos should be empty")
    }
}
