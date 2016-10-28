import UIKit
import FirebaseAuth
import FBSDKLoginKit

class VLogin:UIView
{
    weak var controller:CLogin!
    private let kButtonMargin:CGFloat = 20
    private let kDiclaimerHeight:CGFloat = 60
    private let kDiclaimerMargin:CGFloat = 10
    
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
        
        let diclaimer:UILabel = UILabel()
        diclaimer.isUserInteractionEnabled = false
        diclaimer.translatesAutoresizingMaskIntoConstraints = false
        diclaimer.numberOfLines = 0
        diclaimer.backgroundColor = UIColor.clear
        diclaimer.font = UIFont.regular(size:12)
        diclaimer.textAlignment = NSTextAlignment.center
        diclaimer.textColor = UIColor.white
        diclaimer.text = NSLocalizedString("VLogin_diclaimer", comment:"")
        
        addSubview(logoView)
        addSubview(loginButton)
        addSubview(diclaimer)
        
        let views:[String:UIView] = [
            "logoView":logoView,
            "loginButton":loginButton,
            "diclaimer":diclaimer]
        
        let metrics:[String:CGFloat] = [
            "buttonMargin":kButtonMargin,
            "diclaimerHeight":kDiclaimerHeight,
            "diclaimerMargin":kDiclaimerMargin]
        
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
            withVisualFormat:"V:|-(diclaimerMargin)-[diclaimer]-(diclaimerMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[logoView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[diclaimer(diclaimerHeight)]-(diclaimerMargin)-[loginButton(40)]-(buttonMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
