import UIKit
import FBSDKShareKit

class VSettingsCellFacebookShare:VSettingsCell
{
    private weak var fbButton:FBSDKShareButton!
    private weak var layoutFbButtonLeft:NSLayoutConstraint!
    private let kFbButtonTop:CGFloat = 50
    private let kStringUrl:String = "https://itunes.apple.com/us/app/nubecero/id1012571476"
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        guard
            
            let url:URL = URL(string:kStringUrl)
        
        else
        {
            return
        }
        
        let title:UILabel = UILabel()
        title.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.font = UIFont.medium(size:14)
        title.textColor = UIColor.main
        title.textAlignment = NSTextAlignment.center
        title.text = NSLocalizedString("VSettingsCellFacebookShare_labelTitle", comment:"")
        
        let fbContent:FBSDKShareLinkContent = FBSDKShareLinkContent()
        fbContent.contentURL = url
        
        let fbButton:FBSDKShareButton = FBSDKShareButton()
        fbButton.shareContent = fbContent
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        self.fbButton = fbButton
        
        addSubview(title)
        addSubview(fbButton)
        
        let views:[String:UIView] = [
            "fbButton":fbButton,
            "title":title]
        
        let metrics:[String:CGFloat] = [
            "fbButtonTop":kFbButtonTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[title(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[title]-0-|",
            options:[],
            metrics:metrics,
            views:views))
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
