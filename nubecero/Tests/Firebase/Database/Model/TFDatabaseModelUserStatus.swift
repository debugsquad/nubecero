import XCTest
@testable import nubecero

class TFDatabaseModelUserStatus:XCTestCase
{
    func testInitSnapshotActive()
    {
        let status:FDatabaseModelUser.Status = FDatabaseModelUser.Status.active
        let snapshot:Any = status.rawValue
        
        let fDatabaseModelUserStatus:FDatabaseModelUserStatus = FDatabaseModelUserStatus(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUserStatus.status,
            status,
            "Parsing status active error")
    }
    
    func testInitSnapshotUnknown()
    {
        let status:FDatabaseModelUser.Status = FDatabaseModelUser.Status.unknown
        let snapshot:Any = status.rawValue
        
        let fDatabaseModelUserStatus:FDatabaseModelUserStatus = FDatabaseModelUserStatus(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUserStatus.status,
            status,
            "Parsing status unknown error")
    }
    
    func testInitSnapshotBanned()
    {
        let status:FDatabaseModelUser.Status = FDatabaseModelUser.Status.banned
        let snapshot:Any = status.rawValue
        
        let fDatabaseModelUserStatus:FDatabaseModelUserStatus = FDatabaseModelUserStatus(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUserStatus.status,
            status,
            "Parsing status banned error")
    }
    
    func testInitSnapshotNil()
    {
        let status:FDatabaseModelUser.Status = FDatabaseModelUser.Status.unknown
        let snapshot:Any = 0
        
        let fDatabaseModelUserStatus:FDatabaseModelUserStatus = FDatabaseModelUserStatus(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUserStatus.status,
            status,
            "Parsing status nil")
    }
}
