import XCTest
@testable import nubecero

class TFDatabaseModelAlbum:XCTestCase
{
    private let kName:String = "a super cool nubecero album"
    private let kCreated:TimeInterval = 154423
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    
    func testInitName()
    {
        let currentTime:TimeInterval = NSDate().timeIntervalSince1970
        
        let keyName:String = FDatabaseModelAlbum.Property.name.rawValue
        let keyCreated:String = FDatabaseModelAlbum.Property.created.rawValue
        let model:FDatabaseModelAlbum = FDatabaseModelAlbum(
            name:kName)
        
        XCTAssertEqual(
            model.name,
            kName,
            "Error storing name")
        
        XCTAssertGreaterThanOrEqual(
            model.created,
            currentTime,
            "Error created should be higher than current time")
        
        let modelJson:[String:Any]? = model.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error json is nil")
        
        let jsonCreated:TimeInterval? = modelJson?[keyCreated] as? TimeInterval
        let jsonName:String? = modelJson?[keyName] as? String
        
        XCTAssertGreaterThanOrEqual(
            jsonCreated!,
            currentTime,
            "Error json created")
        
        XCTAssertEqual(
            jsonName,
            kName,
            "Error json name")
    }
    
    func testInitSnapshot()
    {
        let keyName:String = FDatabaseModelAlbum.Property.name.rawValue
        let keyCreated:String = FDatabaseModelAlbum.Property.created.rawValue
        
        let snapshot:[String:Any] = [
            keyName:kName,
            keyCreated:kCreated
        ]
        
        let model:FDatabaseModelAlbum = FDatabaseModelAlbum(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.name,
            kName,
            "Error storing name")
        
        XCTAssertGreaterThanOrEqual(
            model.created,
            kCreated,
            "Error storing created")
    }
    
    func testInitNil()
    {
        let snapshot:Any? = nil
        
        let model:FDatabaseModelAlbum = FDatabaseModelAlbum(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.name,
            kEmpty,
            "Error empty name")
        
        XCTAssertGreaterThanOrEqual(
            model.created,
            kNoTime,
            "Error no created")
    }
}
