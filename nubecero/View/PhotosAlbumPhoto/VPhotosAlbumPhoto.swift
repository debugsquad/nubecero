import UIKit

class VPhotosAlbumPhoto:UIView
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var imageView:UIImageView!
    private weak var layoutBarTop:NSLayoutConstraint!
    private weak var layoutImageTop:NSLayoutConstraint!
    private weak var layoutImageBottom:NSLayoutConstraint!
    private weak var layoutImageRight:NSLayoutConstraint!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private let kBackgroundAnimationDuration:TimeInterval = 0.05
    private let kImageAnimationDuration:TimeInterval = 0.3
    private let kBarAnimationDuration:TimeInterval = 0.3
    
    convenience init(controller:CPhotosAlbumPhoto)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let screenSize:CGSize = UIScreen.main.bounds.size
        let screenWidth:CGFloat = screenSize.width
        let screenHeight:CGFloat = screenSize.height
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        let imageTop:CGFloat = controller.inRect.origin.y
        let imageLeft:CGFloat = controller.inRect.origin.x
        let imageBottom:CGFloat = controller.inRect.maxY - screenHeight
        let imageRight:CGFloat = controller.inRect.maxX - screenWidth
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = controller.model.state?.loadImage()
        self.imageView = imageView
        
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
        
        let bar:VPhotosAlbumPhotoBar = VPhotosAlbumPhotoBar(controller:controller)
        
        background.addSubview(visualEffect)
        addSubview(background)
        addSubview(imageView)
        addSubview(bar)
        
        let views:[String:UIView] = [
            "background":background,
            "visualEffect":visualEffect,
            "bar":bar]
        
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
            withVisualFormat:"V:[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBarTop = NSLayoutConstraint(
            item:bar,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:-barHeight)
        
        layoutImageTop = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:imageTop)
        
        layoutImageBottom = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:imageBottom)
        
        layoutImageRight = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:imageRight)
        
        layoutImageLeft = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:imageLeft)
        
        addConstraint(layoutBarTop)
        addConstraint(layoutImageTop)
        addConstraint(layoutImageBottom)
        addConstraint(layoutImageRight)
        addConstraint(layoutImageLeft)
        
        let imageAnimationDuration:TimeInterval = kImageAnimationDuration
        let barAnimationDuration:TimeInterval = kBarAnimationDuration
        
        UIView.animate(
            withDuration:kBackgroundAnimationDuration,
            animations:
            {
                background.alpha = 1
            })
        { [weak self] (done:Bool) in
            
            self?.layoutImageTop.constant = 0
            self?.layoutImageBottom.constant = 0
            self?.layoutImageRight.constant = 0
            self?.layoutImageLeft.constant = 0
            
            UIView.animate(
                withDuration:
                imageAnimationDuration,
                animations:
                { [weak self] in
                    
                    self?.layoutIfNeeded()
                    
                })
            { [weak self] (done:Bool) in
                
                self?.layoutBarTop.constant = 0
                self?.layoutImageTop.constant = barHeight
                
                UIView.animate(
                    withDuration:
                    barAnimationDuration)
                    { [weak self] in
                        
                        self?.layoutIfNeeded()
                    }
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedImageLoaded(sender:)),
            name:Notification.imageDataLoaded,
            object:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notified
    
    func notifiedImageLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
            { [weak self] in
                
            guard
                
                let picture:MPhotosItemPhoto = notification.object as? MPhotosItemPhoto
                
            else
            {
                return
            }
            
            if picture === self?.controller.model
            {
                self?.imageView.image = picture.resources.image
            }
        }
    }
}
