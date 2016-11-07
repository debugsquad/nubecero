import XCTest
@testable import nubecero

class TFDatabaseModelUser:XCTestCase
{
    private let kCreated:TimeInterval = 123456
    private let kLastSession:TimeInterval = 45678
    private let kDiskUsed:Int = 3098765
    
    func testInitSnapshot()
    {
        let status:FDatabaseModelUser.Status = FDatabaseModelUser.Status.active
        
        let snapshot:[String:Any] = [
            FDatabaseModelUser.Property.status.rawValue:status.rawValue,
            FDatabaseModelUser.Property.created.rawValue:kCreated,
            FDatabaseModelUser.Property.lastSession.rawValue:kLastSession,
            FDatabaseModelUser.Property.diskUsed.rawValue:kDiskUsed
        ]
        
        let fDatabaseModelUser:FDatabaseModelUser = FDatabaseModelUser(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUser.status,
            status,
            "Parsing status error")
        
        XCTAssertEqual(
            fDatabaseModelUser.created,
            kCreated,
            "Parsing created error")
        
        XCTAssertEqual(
            fDatabaseModelUser.lastSession,
            kLastSession,
            "Parsing last session error")
        
        XCTAssertEqual(
            fDatabaseModelUser.diskUsed,
            kDiskUsed,
            "Parsing disk used error")
        
        let modelJson:[String:Any]? = fDatabaseModelUser.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        /*
        XCTAssertEqual(
            modelJson![FDatabaseModelUser.Property.status.rawValue],
            status.rawValue,
            "Parsing json status error")
        
        XCTAssertEqual(
            fDatabaseModelUser.created,
            kCreated,
            "Parsing created error")
        
        XCTAssertEqual(
            fDatabaseModelUser.lastSession,
            kLastSession,
            "Parsing last session error")
        
        XCTAssertEqual(
            fDatabaseModelUser.diskUsed,
            kDiskUsed,
            "Parsing disk used error")*/
    }
    
    func testInitSnapshotUserBanned()
    {
        let status:FDatabaseModelUser.Status = FDatabaseModelUser.Status.banned
        
        let snapshot:[String:Any] = [
            FDatabaseModelUser.Property.status.rawValue:status.rawValue
        ]
        
        let fDatabaseModelUser:FDatabaseModelUser = FDatabaseModelUser(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUser.status,
            status,
            "User banned not working")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:[String:Any] = [:]
        
        let fDatabaseModelUser:FDatabaseModelUser = FDatabaseModelUser(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUser.status,
            FDatabaseModelUser.Status.unknown,
            "Snapshot nil not using unknown status")
    }
}
