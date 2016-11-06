import XCTest
@testable import nubecero

class TVSettingsCellProfile:XCTestCase
{
    func testUserName()
    {
        let vSettingsCellProfile:VSettingsCellProfile = VSettingsCellProfile(frame:CGRect.zero)
        
        XCTAssertNotNil(name, "name is nil")
    }
}
