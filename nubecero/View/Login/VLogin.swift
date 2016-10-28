import UIKit
import FirebaseAuth
import FBSDKLoginKit

class VLogin:UIView
{
    weak var controller:CLogin!
    private let kButtonMargin:CGFloat = 20
    private let kDisclaimerHeight:CGFloat = 60
    private let kDisclaimerMargin:CGFloat = 10
    
    convenience init(controller:CLogin)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.main
        self.controller = controller
        
        let logoView:UIImageView = UIImageView()
        logoView.isUserInteractionEnabled = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.clipsToBounds = true
        logoView.contentMode = UIViewContentMode.center
        logoView.image = #imageLiteral(resourceName: "assetGenericLogo")
        
        let loginButton:FBSDKLoginButton = FBSDKLoginButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.delegate = controller
        
        let disclaimer:UILabel = UILabel()
        disclaimer.isUserInteractionEnabled = false
        disclaimer.translatesAutoresizingMaskIntoConstraints = false
        disclaimer.numberOfLines = 0
        disclaimer.backgroundColor = UIColor.clear
        disclaimer.font = UIFont.regular(size:12)
        disclaimer.textAlignment = NSTextAlignment.center
        disclaimer.textColor = UIColor.white
        disclaimer.text = NSLocalizedString("VLogin_disclaimer", comment:"")
        
        addSubview(logoView)
        addSubview(loginButton)
        addSubview(disclaimer)
        
        let views:[String:UIView] = [
            "logoView":logoView,
            "loginButton":loginButton,
            "disclaimer":disclaimer]
        
        let metrics:[String:CGFloat] = [
            "buttonMargin":kButtonMargin,
            "disclaimerHeight":kDisclaimerHeight,
            "disclaimerMargin":kDisclaimerMargin]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[logoView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(buttonMargin)-[loginButton]-(buttonMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(disclaimerMargin)-[disclaimer]-(disclaimerMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[logoView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[disclaimer(disclaimerHeight)]-(disclaimerMargin)-[loginButton(40)]-(buttonMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
