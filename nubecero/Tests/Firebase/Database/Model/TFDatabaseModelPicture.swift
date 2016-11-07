import XCTest
@testable import nubecero

class TFDatabaseModelPicture:XCTestCase
{
    private let kCreated:TimeInterval = 123456
    private let kSize:Int = 98655
    
    func testInitSnapshot()
    {
        let status:FDatabaseModelPicture.Status = FDatabaseModelPicture.Status.synced
        let keyCreated:String = FDatabaseModelPicture.Property.created.rawValue
        let keyStatus:String = FDatabaseModelPicture.Property.status.rawValue
        let keySize:String = FDatabaseModelPicture.Property.size.rawValue
        
        let snapshot:[String:Any] = [
            keyCreated:kCreated,
            keyStatus:status.rawValue,
            keySize:kSize
        ]
        
        let fDatabaseModelPicture:FDatabaseModelPicture = FDatabaseModelPicture(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelPicture.created,
            kCreated,
            "Error parsing created")
        
        XCTAssertEqual(
            fDatabaseModelPicture.status,
            status,
            "Error parsing status")
        
        XCTAssertEqual(
            fDatabaseModelPicture.size,
            kSize,
            "Error parsing size")
        
        let modelJson:[String:Any]? = fDatabaseModelPicture.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        
        let jsonCreated:TimeInterval? = modelJson![keyCreated] as? TimeInterval
        let jsonStatusInt:Int? = modelJson![keyStatus] as? Int
        let jsonSize:Int? = modelJson![keySize] as? Int
        
        XCTAssertEqual(
            kCreated,
            jsonCreated,
            "Created received from json is no the same as the stored")
        
        XCTAssertNotNil(
            jsonStatusInt,
            "Error storing status on json")
        
        let jsonStatus:FDatabaseModelPicture.Status? = FDatabaseModelPicture.Status(
            rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            status,
            jsonStatus,
            "Status received from json is no the same as the stored")
        
        XCTAssertEqual(
            kSize,
            jsonSize,
            "Size received from json is no the same as the stored")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:Any = ""
        
        let fDatabaseModelUserPicture:FDatabaseModelPicture = FDatabaseModelPicture(
            snapshot:snapshot)
        
        XCTAssertEqual(
            FDatabaseModelPicture.status,
            FDatabaseModelPicture.Status.waiting,
            "Snapshot nil not using waiting status")
    }
}
