import XCTest
@testable import nubecero

class TFDatabaseModelPictureList:XCTestCase
{
    private let kPictureIdA:MPictures.PictureId = "hello world"
    private let kPictureIdB:MPictures.PictureId = "nubecero"
    private let kPictureIdC:MPictures.PictureId = "swift"
    private let kEmpty:Any = ""
    private let kNoPictures:Int = 0
    
    func testInitSnapshot()
    {
        let snapshot:[MPictures.PictureId:Any] = [
            kPictureIdA:kEmpty,
            kPictureIdB:kEmpty,
            kPictureIdC:kEmpty
        ]
        
        let fDatabaseModelPictureList:FDatabaseModelPictureList = FDatabaseModelPictureList(
            snapshot:snapshot)
        
        let snapshotKeys:[MPictures.PictureId] = Array(snapshot.keys)
        let countPictures:Int = fDatabaseModelPictureList.items.count
        let countSnapshotKeys:Int = snapshotKeys.count
        
        XCTAssertEqual(
            countSnapshotKeys,
            countPictures,
            "Not the same amount of items parsed")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:Any = kEmpty
        
        let fDatabaseModelPictureList:FDatabaseModelPictureList = FDatabaseModelPictureList(
            snapshot:snapshot)
        
        let countPictures:Int = fDatabaseModelPictureList.items.count
        
        XCTAssertEqual(
            kNoPictures,
            countPictures,
            "Pictures should be empty")
    }
}
