import UIKit

class VPicturesData:UIView
{
    weak var controller:CPicturesData!
    
    convenience init(controller:CPicturesData)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let blurView:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.clipsToBounds = true
        
        addSubview(blurView)
        
        let views:[String:UIView] = [
            "blurView":blurView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[blurView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[blurView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
