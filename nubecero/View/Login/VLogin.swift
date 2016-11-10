import UIKit
import FirebaseAuth

class VLogin:UIView
{
    private weak var controller:CLogin!
    
    convenience init(controller:CLogin)
    {
        self.init()
        isUserInteractionEnabled = false
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
        
        addSubview(logoView)
        
        let views:[String:UIView] = [
            "logoView":logoView]
        
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
    }
}
