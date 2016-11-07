import XCTest
@testable import nubecero

class TVSettingsCellProfile:XCTestCase
{
    private var vSettingsCellProfile:VSettingsCellProfile?
    
    override func setUp()
    {
        super.setUp()
        vSettingsCellProfile = VSettingsCellProfile(frame:CGRect.zero)
    }
    
    func testUserName()
    {
        let userName:String? = vSettingsCellProfile?.userName.text
        
        XCTAssertNotNil(userName, "Username can't be nil")
        XCTAssertGreaterThan(userName!.characters.count, 0, "Username can't be empty")
    }
    
    func testImageView()
    {
        let image:UIImage? = vSettingsCellProfile?.imageView.image
        
        XCTAssertNotNil(image, "Profile image can't be nil")
    }
}
