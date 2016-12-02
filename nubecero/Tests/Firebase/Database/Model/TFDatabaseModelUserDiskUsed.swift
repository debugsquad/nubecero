import XCTest
@testable import nubecero

class TFDatabaseModelUserDiskUsed:XCTestCase
{
    private let kDiskUsed:Int = 12345678
    private let kDiskUsedZero:Int = 0
    
    func testInitSnapshot()
    {
        let snapshot:Any = kDiskUsed
        
        let model:FDatabaseModelUserDiskUsed = FDatabaseModelUserDiskUsed(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.diskUsed,
            kDiskUsed,
            "Parsing disk used error")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:Any = ""
        
        let model:FDatabaseModelUserDiskUsed = FDatabaseModelUserDiskUsed(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.diskUsed,
            kDiskUsedZero,
            "Parsing disk used nil error")
    }
}
