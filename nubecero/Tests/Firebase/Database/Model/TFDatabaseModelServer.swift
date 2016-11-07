import XCTest
@testable import nubecero

class TFDatabaseModelServer:XCTestCase
{
    private let kFroobSpace:Int = 2434234
    
    func testInitSnapshot()
    {
        let keyFroobSpace:String = FDatabaseModelServer.Property.froobSpace.rawValue
        
        let snapshot:[String:Any] = [
            keyFroobSpace:kFroobSpace
        ]
        
        let fDatabaseModelServer:FDatabaseModelServer = FDatabaseModelServer(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelServer.froobSpace,
            kFroobSpace,
            "Error parsing froob space")
        
        let modelJson:[String:Any]? = fDatabaseModelServer.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        
        let jsonFroobSpace:Int? = modelJson?[keyFroobSpace] as? Int
        
        XCTAssertEqual(
            jsonFroobSpace,
            kFroobSpace,
            "Error storing froob space on json model")
    }
}
