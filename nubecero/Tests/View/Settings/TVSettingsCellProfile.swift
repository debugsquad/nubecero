import XCTest
@testable import nubecero

class TVSettingsCellProfile:XCTestCase
{
    func testUserName()
    {
        let vSettingsCellProfile:VSettingsCellProfile = VSettingsCellProfile(frame:CGRect.zero)
        let userName:String? = vSettingsCellProfile.userName.text
        
        XCTAssertNotNil(userName, "Username can't be nil")
        XCTAssertGreaterThan(userName!.characters.count, 0, "Username can't be empty")
    }
}
