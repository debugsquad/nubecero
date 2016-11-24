import UIKit

class VPhotosAlbumPhoto:UIView
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var viewList:VPhotosAlbumPhotoList!
    private let kBackgroundAnimationDuration:TimeInterval = 0.05
    private let kBarAnimationDuration:TimeInterval = 0.3
    private let kAfterBarAppear:TimeInterval = 0.5
    
    convenience init(controller:CPhotosAlbumPhoto)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.alpha = 0
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        
        let bar:VPhotosAlbumPhotoBar = VPhotosAlbumPhotoBar(
            controller:controller)
        
        let viewList:VPhotosAlbumPhotoList = VPhotosAlbumPhotoList(
            controller:controller)
        self.viewList = viewList
        
        background.addSubview(visualEffect)
        addSubview(background)
        addSubview(viewList)
        addSubview(bar)
        
        let views:[String:UIView] = [
            "background":background,
            "visualEffect":visualEffect,
            "bar":bar,
            "viewList":viewList]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewList]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[bar(barHeight)]-0-[viewList]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        let layoutBarTop:NSLayoutConstraint = NSLayoutConstraint(
            item:bar,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:-barHeight)
        
        addConstraint(layoutBarTop)
        
        let barAnimationDuration:TimeInterval = kBarAnimationDuration
        
        UIView.animate(
            withDuration:kBackgroundAnimationDuration)
        {
            background.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterBarAppear)
        {
            layoutBarTop.constant = 0
            
            UIView.animate(withDuration:barAnimationDuration)
            { [weak self] in
                
                self?.layoutIfNeeded()
            }
        }
    }
}
