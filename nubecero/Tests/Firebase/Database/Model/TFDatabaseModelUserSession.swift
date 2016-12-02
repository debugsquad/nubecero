import XCTest
@testable import nubecero

class TFDatabaseModelUserSession:XCTestCase
{
    private let kToken:String? = "ddsfkjfsjksd3324fd"
    private let kVersion:String = "312"
    private let kTtl:Int? = 134398765
    private let kTimestamp:TimeInterval = 1344556
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    private let kNoTtl:Int = 0
    
    func testInitTokenVersionTtl()
    {
        let initialStatus:MSession.Status = MSession.Status.active
        let currentTime:TimeInterval = NSDate().timeIntervalSince1970
        
        let keyStatus:String = FDatabaseModelUserSession.Property.status.rawValue
        let keyToken:String = FDatabaseModelUserSession.Property.token.rawValue
        let keyVersion:String = FDatabaseModelUserSession.Property.version.rawValue
        let keyTimestamp:String = FDatabaseModelUserSession.Property.timestamp.rawValue
        let keyTtl:String = FDatabaseModelUserSession.Property.ttl.rawValue
        
        let model:FDatabaseModelUserSession = FDatabaseModelUserSession(
            token:kToken,
            version:kVersion,
            ttl:kTtl)
        
        XCTAssertEqual(
            model.token,
            kToken,
            "Error storing token")
        
        XCTAssertEqual(
            model.version,
            kVersion,
            "Error storing version")
        
        XCTAssertEqual(
            model.ttl,
            kTtl,
            "Error storing ttl")
        
        XCTAssertGreaterThanOrEqual(
            model.timestamp,
            currentTime,
            "Error timestamp should be greater or equal to starting time")
        
        XCTAssertEqual(
            model.status,
            initialStatus,
            "Error user should be acitve on creation")
        
        let modelJson:[String:Any]? = model.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        
        let jsonStatusInt:Int? = modelJson?[keyStatus] as? Int
        let jsonToken:String? = modelJson?[keyToken] as? String
        let jsonVersion:String? = modelJson?[keyVersion] as? String
        let jsonTimeStamp:TimeInterval? = modelJson?[keyTimestamp] as? TimeInterval
        let jsonTtl:Int? = modelJson?[keyTtl] as? Int
        
        XCTAssertNotNil(
            jsonStatusInt,
            "Error with status on json")
        
        let jsonStatus:MSession.Status? = MSession.Status(rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            initialStatus,
            jsonStatus,
            "Error with initial status on json")
        
        XCTAssertEqual(
            kToken,
            jsonToken,
            "Error with token on json")
        
        XCTAssertEqual(
            kVersion,
            jsonVersion,
            "Error with version on json")
        
        XCTAssertNotNil(
            jsonTimeStamp,
            "Error timestamp is nil")
        
        XCTAssertGreaterThanOrEqual(
            jsonTimeStamp!,
            currentTime,
            "Error with timestamp on json")
        
        XCTAssertEqual(
            kTtl,
            jsonTtl,
            "Error with ttl on json")
    }
    
    func testInitTokenNil()
    {
        let model:FDatabaseModelUserSession = FDatabaseModelUserSession(
            token:nil,
            version:kVersion,
            ttl:kTtl)
        
        XCTAssertEqual(
            model.token,
            kEmpty,
            "Error token should be empty")
    }
    
    func testInitTtlNil()
    {
        let model:FDatabaseModelUserSession = FDatabaseModelUserSession(
            token:kToken,
            version:kVersion,
            ttl:nil)
        
        XCTAssertEqual(
            model.ttl,
            kNoTtl,
            "Error ttl should be zero")
    }
    
    func testInitSnapshot()
    {
        let initialStatus:MSession.Status = MSession.Status.active
        
        let keyStatus:String = FDatabaseModelUserSession.Property.status.rawValue
        let keyToken:String = FDatabaseModelUserSession.Property.token.rawValue
        let keyVersion:String = FDatabaseModelUserSession.Property.version.rawValue
        let keyTimestamp:String = FDatabaseModelUserSession.Property.timestamp.rawValue
        let keyTtl:String = FDatabaseModelUserSession.Property.ttl.rawValue
        
        let snapshot:[String:Any] = [
            keyStatus:initialStatus.rawValue,
            keyToken:kToken,
            keyVersion:kVersion,
            keyTimestamp:kTimestamp,
            keyTtl:kTtl
        ]
        
        let model:FDatabaseModelUserSession = FDatabaseModelUserSession(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.status,
            initialStatus,
            "Error storing status")
        
        XCTAssertEqual(
            model.token,
            kToken,
            "Error storing token")
        
        XCTAssertEqual(
            model.version,
            kVersion,
            "Error storing version")
        
        XCTAssertEqual(
            model.timestamp,
            kTimestamp,
            "Error storing timestamp")
        
        XCTAssertEqual(
            model.ttl,
            kTtl,
            "Error storing ttl")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:Any? = nil
        
        let model:FDatabaseModelUserSession = FDatabaseModelUserSession(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.status,
            MSession.Status.unknown,
            "Error default status")
        
        XCTAssertEqual(
            model.token,
            kEmpty,
            "Error default token")
        
        XCTAssertEqual(
            model.version,
            kEmpty,
            "Error default version")
        
        XCTAssertEqual(
            model.timestamp,
            kNoTime,
            "Error default timestamp")
        
        XCTAssertEqual(
            model.ttl,
            kNoTtl,
            "Error default ttl")
    }
    
    func testInitStatusActive()
    {
        let status:MSession.Status = MSession.Status.active
        
        let keyStatus:String = FDatabaseModelUserSession.Property.status.rawValue
        
        let snapshot:[String:Any] = [
            keyStatus:status.rawValue,
        ]
        
        let model:FDatabaseModelUserSession = FDatabaseModelUserSession(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.status,
            status,
            "Error status active")
        
        let modelJson:[String:AnyObject]? = model.modelJson() as? [String:AnyObject]
        let jsonStatusInt:Int? = modelJson?[keyStatus] as? Int
        let jsonStatus:MSession.Status? = MSession.Status(rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            jsonStatus,
            status,
            "Error json status")
    }
    
    func testInitStatusBanned()
    {
        let status:MSession.Status = MSession.Status.banned
        
        let keyStatus:String = FDatabaseModelUserSession.Property.status.rawValue
        
        let snapshot:[String:Any] = [
            keyStatus:status.rawValue,
            ]
        
        let model:FDatabaseModelUserSession = FDatabaseModelUserSession(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.status,
            status,
            "Error status banned")
        
        let modelJson:[String:AnyObject]? = model.modelJson() as? [String:AnyObject]
        let jsonStatusInt:Int? = modelJson?[keyStatus] as? Int
        let jsonStatus:MSession.Status? = MSession.Status(rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            jsonStatus,
            status,
            "Error json status")
    }
}
