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
        let keyStatus:String = FDatabaseModelUser.Property.status.rawValue
        let keyCreated:String = FDatabaseModelUser.Property.created.rawValue
        let keyLastSession:String = FDatabaseModelUser.Property.lastSession.rawValue
        let keyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
        
        let snapshot:[String:Any] = [
            keyStatus:status.rawValue,
            keyCreated:kCreated,
            keyLastSession:kLastSession,
            keyDiskUsed:kDiskUsed
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
        
        let jsonStatusInt:Int? = modelJson![keyStatus] as? Int
        let jsonCreated:TimeInterval? = modelJson![keyCreated] as? TimeInterval
        let jsonLastSession:TimeInterval? = modelJson![keyLastSession] as? TimeInterval
        let jsonDiskUsed:Int? = modelJson![keyDiskUsed] as? Int
        
        XCTAssertNotNil(
            jsonStatusInt,
            "Error storing status on json")
        
        let jsonStatus:FDatabaseModelUser.Status? = FDatabaseModelUser.Status(
            rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            status,
            jsonStatus,
            "Status received from json is no the same as the stored")
        
        XCTAssertEqual(
            kCreated,
            jsonCreated,
            "Created received from json is not the same as the stored")
        
        XCTAssertEqual(
            kLastSession,
            jsonLastSession,
            "Last session received from json is not the same as the stored")
        
        XCTAssertEqual(
            kDiskUsed,
            jsonDiskUsed,
            "Disk used received from json is not the same as the recived")
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
