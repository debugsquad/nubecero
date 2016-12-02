import XCTest
@testable import nubecero

class TFDatabaseModelUserList:XCTestCase
{
    private let kUserIdA:MPhotos.PhotoId = "johnny"
    private let kUserIdB:MPhotos.PhotoId = "test"
    private let kUserIdC:MPhotos.PhotoId = "user"
    private let kEmpty:Any = ""
    private let kCreated:TimeInterval = 123456
    private let kNoUsers:Int = 0
    
    func testInitSnapshot()
    {
        let keyCreated:String = FDatabaseModelUser.Property.created.rawValue
        
        let snapshot:[MPhotos.PhotoId:Any] = [
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
}
