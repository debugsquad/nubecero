import UIKit
import FirebaseAuth
import FBSDKLoginKit

class VLogin:UIView
{
    weak var controller:CLogin!
    
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
        
        addSubview(logoView)
        addSubview(loginButton)
        
        let views:[String:UIView] = [
            "logoView":logoView,
            "loginButton":loginButton]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[logoView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[logoView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[loginButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[loginButton(40)]-10-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
