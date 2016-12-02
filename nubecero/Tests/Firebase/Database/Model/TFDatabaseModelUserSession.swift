import XCTest
@testable import nubecero

class TFDatabaseModelUserSession:XCTestCase
{
    private let kToken:String? = "ddsfkjfsjksd3324fd"
    private let kVersion:String = "312"
    private let kTtl:Int? = 134398765
    
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
}
