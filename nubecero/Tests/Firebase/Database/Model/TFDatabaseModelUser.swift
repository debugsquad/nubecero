import XCTest
@testable import nubecero

class TFDatabaseModelUser:XCTestCase
{
    private let kEmail:String = "atest@mail.com"
    private let kToken:String? = "ffsdn3342fsdlmfnsdkfns34423"
    private let kVersion:String = "123"
    private let kCreated:TimeInterval = 123456
    private let kDiskUsed:Int = 3098765
    private let kDiskInitial:Int = 0
    private let kNoTime:TimeInterval = 0
    private let kEmpty:String = ""
    
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
        
        let model:FDatabaseModelUser = FDatabaseModelUser(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.email,
            kEmail,
            "Parsing email error")
        
        XCTAssertEqual(
            model.created,
            kCreated,
            "Parsing created error")
        
        XCTAssertEqual(
            model.diskUsed,
            kDiskUsed,
            "Parsing disk used error")
        
        let modelJson:[String:Any]? = model.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        
        let jsonEmail:String? = modelJson?[keyEmail] as? String
        let jsonCreated:TimeInterval? = modelJson?[keyCreated] as? TimeInterval
        let jsonDiskUsed:Int? = modelJson?[keyDiskUsed] as? Int
        
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
    
    func testInitMinValues()
    {
        let snapshot:Any = ""
        
        let model:FDatabaseModelUser = FDatabaseModelUser(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.email,
            kEmpty,
            "Error min email")
        
        XCTAssertGreaterThanOrEqual(
            model.created,
            kNoTime,
            "Error min created")
        
        XCTAssertEqual(
            model.diskUsed,
            kDiskInitial,
            "Error min disk used")
    }
    
    func testInitEmailTokenVersion()
    {
        let currentTime:TimeInterval = Date().timeIntervalSince1970
        
        let model:FDatabaseModelUser = FDatabaseModelUser(
            email:kEmail,
            token:kToken,
            version:kVersion)
        
        XCTAssertEqual(
            model.email,
            kEmail,
            "Error email not matching")
        
        XCTAssertEqual(
            model.session.token,
            kToken,
            "Error session doesn't use the same token")
        
        XCTAssertGreaterThanOrEqual(
            model.created,
            currentTime,
            "Error created has to be greater than current time")
        
        XCTAssertEqual(
            model.diskUsed,
            kDiskInitial,
            "Error disk used not zero")
    }
}
