import UIKit
import FBSDKShareKit

class VSettingsCellFacebookShare:VSettingsCell
{
    private weak var fbButton:FBSDKShareButton!
    private weak var layoutFbButtonLeft:NSLayoutConstraint!
    private let kFbButtonTop:CGFloat = 10
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
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        self.fbButton = fbButton
        
        addSubview(fbButton)
        
        let views:[String:UIView] = [
            "fbButton":fbButton]
        
        let metrics:[String:CGFloat] = [
            "fbButtonTop":kFbButtonTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(fbButtonTop)-[fbButton]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutFbButtonLeft = NSLayoutConstraint(
            item:fbButton,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutFbButtonLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let buttonWidth:CGFloat = fbButton.bounds.maxX
        let remain:CGFloat = width - buttonWidth
        let margin:CGFloat = remain / 2.0
        layoutFbButtonLeft.constant = margin
        
        super.layoutSubviews()
    }
}
