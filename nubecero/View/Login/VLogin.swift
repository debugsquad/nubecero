import UIKit
import FirebaseAuth

class VLogin:UIView
{
    private weak var controller:CLogin!
    private let kMarginHorizontal:CGFloat = 20
    private let kDisclaimerHeight:CGFloat = 60
    
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
            "marginHorizontal":kMarginHorizontal,
            "disclaimerHeight":kDisclaimerHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[logoView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(marginHorizontal)-[loginButton]-(marginHorizontal)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(marginHorizontal)-[disclaimer]-(marginHorizontal)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[logoView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[disclaimer(disclaimerHeight)]-0-[loginButton(40)]-(marginHorizontal)-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
