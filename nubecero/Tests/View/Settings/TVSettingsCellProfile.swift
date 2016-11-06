import XCTest
import FirebaseAuth

class TVSettingsCellProfile:XCTestCase
{
    func testUserName()
    {
        let name = FIRAuth.auth()?.currentUser?.displayName
        
        XCTAssertNotNil(name, "name is nil")
    }
}
