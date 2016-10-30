import UIKit

class VHomeUploadSync:UIView
{
    weak var viewBar:VHomeUploadSyncBar!
    private weak var controller:CHomeUploadSync!
    
    convenience init(controller:CHomeUploadSync)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        visualEffect.isUserInteractionEnabled = false
        
        let viewBar:VHomeUploadSyncBar = VHomeUploadSyncBar(controller:controller)
        self.viewBar = viewBar
        
        addSubview(visualEffect)
        addSubview(viewBar)
        
        let views:[String:UIView] = [
            "visualEffect":visualEffect,
            "viewBar":viewBar]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
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
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewBar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[viewBar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
}
