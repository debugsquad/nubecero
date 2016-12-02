import XCTest
@testable import nubecero

class TFDatabaseModelUserList:XCTestCase
{
    private let kUserIdA:MSession.UserId = "johnny"
    private let kUserIdB:MSession.UserId = "test"
    private let kUserIdC:MSession.UserId = "user"
    private let kEmpty:Any = ""
    private let kCreated:TimeInterval = 123456
    private let kNoUsers:Int = 0
    
    func testInitSnapshot()
    {
        let keyCreated:String = FDatabaseModelUser.Property.created.rawValue
        
        let snapshot:[MSession.UserId:Any] = [
            kUserIdA:[
                keyCreated:kCreated
            ]
        ]
        
        let model:FDatabaseModelPhotoList = FDatabaseModelPhotoList(
            snapshot:snapshot)
        
        XCTAssertNotNil(
            model.items.first,
            "Error parsing first item")
        
        XCTAssertNotNil(
            model.items[kUserIdA],
            "Error parsing first item")
        
        XCTAssertEqual(
            model.items[kUserIdA]!.created,
            kCreated,
            "Error parsing user properties")
    }
    
    func testInitSnapshotEmpty()
    {
        let snapshot:[MSession.UserId:Any] = [
            kUserIdA:kEmpty,
            kUserIdB:kEmpty,
            kUserIdC:kEmpty
        ]
        
        let model:FDatabaseModelUserList = FDatabaseModelUserList(
            snapshot:snapshot)
        
        let snapshotKeys:[MSession.UserId] = Array(snapshot.keys)
        let countUsers:Int = model.items.count
        let countSnapshotKeys:Int = snapshotKeys.count
        
        XCTAssertEqual(
            countSnapshotKeys,
            countUsers,
            "Not the same amount of items parsed")
    }
}
