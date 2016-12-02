import XCTest
@testable import nubecero

class TFDatabaseModelServer:XCTestCase
{
    private let kPlusSpace:Int = 123434324
    private let kFroobSpace:Int = 2434234
    private let kNoSpace:Int = 0
    
    func testInitSnapshot()
    {
        let keyFroobSpace:String = FDatabaseModelServer.Property.froobSpace.rawValue
        let keyPlusSpace:String = FDatabaseModelServer.Property.plusSpace.rawValue
        
        let snapshot:[String:Any] = [
            keyFroobSpace:kFroobSpace,
            keyPlusSpace:kPlusSpace
        ]
        
        let model:FDatabaseModelServer = FDatabaseModelServer(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.froobSpace,
            kFroobSpace,
            "Error parsing froob space")
        
        XCTAssertEqual(
            model.plusSpace,
            kPlusSpace,
            "Error parsing plus space")
        
        let modelJson:[String:Any]? = model.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        
        let jsonFroobSpace:Int? = modelJson?[keyFroobSpace] as? Int
        let jsonPlusSpace:Int? = modelJson?[keyPlusSpace] as? Int
        
        XCTAssertEqual(
            jsonFroobSpace,
            kFroobSpace,
            "Error storing froob space on json model")
        
        XCTAssertEqual(
            jsonPlusSpace,
            kPlusSpace,
            "Error storing plus space on json model")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:Any = ""
        
        let model:FDatabaseModelServer = FDatabaseModelServer(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.froobSpace,
            kNoSpace,
            "When nil snapshot there should be no froob space")
        
        XCTAssertEqual(
            model.plusSpace,
            kNoSpace,
            "When nil snapshot there should be no plus space")
    }
    
    func testInitFroobPlusSpace()
    {
        let model:FDatabaseModelServer = FDatabaseModelServer(
            froobSpace:kFroobSpace,
            plusSpace:kPlusSpace)
        
        XCTAssertEqual(
            model.froobSpace,
            kFroobSpace,
            "Error parsing init with froob space")
        
        XCTAssertEqual(
            model.plusSpace,
            kPlusSpace,
            "Error parsing init with plus space")
    }
}
