import XCTest
@testable import nubecero

class TFDatabaseModelUser:XCTestCase
{
    private let kEmail:String = "atest@mail.com"
    private let kCreated:TimeInterval = 123456
    private let kDiskUsed:Int = 3098765
    private let kDiskInitial:Int = 0
    
    /*
    enum Property:String
    {
        case session = "session"
        case email = "email"
        case created = "created"
        case diskUsed = "diskUsed"
        case photos = "photos"
        case albums = "albums"
    }*/
    
    func testInitSnapshot()
    {
        let keyEmail:String = FDatabaseModelUser.Property.email.rawValue
        let keyCreated:String = FDatabaseModelUser.Property.created.rawValue
        let keyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
        
        let snapshot:[String:Any] = [
            keyEmail:kEmail,
            keyCreated:kCreated,
            keyDiskUsed:kDiskUsed
        ]
        
        let fDatabaseModelUser:FDatabaseModelUser = FDatabaseModelUser(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUser.email,
            kEmail,
            "Parsing email error")
        
        XCTAssertEqual(
            fDatabaseModelUser.created,
            kCreated,
            "Parsing created error")
        
        XCTAssertEqual(
            fDatabaseModelUser.diskUsed,
            kDiskUsed,
            "Parsing disk used error")
        
        let modelJson:[String:Any]? = fDatabaseModelUser.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        
        let jsonEmail:String? = modelJson![keyEmail] as? String
        let jsonCreated:TimeInterval? = modelJson![keyCreated] as? TimeInterval
        let jsonDiskUsed:Int? = modelJson![keyDiskUsed] as? Int
        
        XCTAssertEqual(
            kEmail,
            jsonEmail,
            "Email received from json is no the same as the stored")
        
        XCTAssertEqual(
            kCreated,
            jsonCreated,
            "Created received from json is not the same as the stored")
        
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
        let snapshot:Any = ""
        
        let fDatabaseModelUser:FDatabaseModelUser = FDatabaseModelUser(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelUser.status,
            FDatabaseModelUser.Status.unknown,
            "Snapshot nil not using unknown status")
    }
    
    func testInitStatus()
    {
        let status:FDatabaseModelUser.Status = FDatabaseModelUser.Status.active
        let currentTime:TimeInterval = Date().timeIntervalSince1970
        
        let fDatabaseModelUser:FDatabaseModelUser = FDatabaseModelUser(
            status:status)
        
        XCTAssertEqual(
            fDatabaseModelUser.status,
            status,
            "Error init with status")
        
        XCTAssertGreaterThanOrEqual(
            fDatabaseModelUser.created,
            currentTime,
            "Error making the created timestamp")
        
        XCTAssertEqual(
            fDatabaseModelUser.created,
            fDatabaseModelUser.lastSession,
            "Last session and created are not the same")
        
        XCTAssertEqual(
            fDatabaseModelUser.diskUsed,
            kDiskInitial,
            "Error initializing disk space")
    }
}
