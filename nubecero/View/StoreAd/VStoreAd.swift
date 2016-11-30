import UIKit

class VStoreAd:UIView
{
    private weak var controller:CStoreAd!
    
    convenience init(controller:CStoreAd)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        
        addSubview(visualEffect)
        
        let views:[String:UIView] = [
            "visualEffect":visualEffect]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
