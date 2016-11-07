import UIKit
import FBSDKShareKit

class VSettingsCellFacebookShare:VSettingsCell
{
    private let kStringUrl:String = "https://www.facebook.com/FacebookDevelopers"
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        guard
            
            let url:URL = URL(string:kStringUrl)
        
        else
        {
            return
        }
        
        let fbContent:FBSDKShareLinkContent = FBSDKShareLinkContent()
        fbContent.contentURL = url
        
        let fbButton:FBSDKShareButton = FBSDKShareButton()
        fbButton.shareContent = fbContent
        fbButton.center = center
        
        addSubview(fbButton)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
