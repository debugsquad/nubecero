import UIKit

class VPhotosAlbumPhoto:UIView
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var viewList:VPhotosAlbumPhotoList!
    private weak var layoutBarTop:NSLayoutConstraint!
    private weak var layoutListTop:NSLayoutConstraint!
    private weak var layoutListBottom:NSLayoutConstraint!
    private weak var layoutListRight:NSLayoutConstraint!
    private weak var layoutListLeft:NSLayoutConstraint!
    private let kBackgroundAnimationDuration:TimeInterval = 0.05
    private let kListAnimationDuration:TimeInterval = 0.3
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
        
        layoutListTop = NSLayoutConstraint(
            item:viewList,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:imageTop)
        
        layoutListBottom = NSLayoutConstraint(
            item:viewList,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:imageBottom)
        
        layoutListRight = NSLayoutConstraint(
            item:viewList,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:imageRight)
        
        layoutListLeft = NSLayoutConstraint(
            item:viewList,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:imageLeft)
        
        addConstraint(layoutBarTop)
        addConstraint(layoutListTop)
        addConstraint(layoutListBottom)
        addConstraint(layoutListRight)
        addConstraint(layoutListLeft)
        
        let listAnimationDuration:TimeInterval = kListAnimationDuration
        let barAnimationDuration:TimeInterval = kBarAnimationDuration
        
        UIView.animate(
            withDuration:kBackgroundAnimationDuration,
            animations:
            {
                background.alpha = 1
            })
        { [weak self] (done:Bool) in
            
            self?.layoutListTop.constant = 0
            self?.layoutListBottom.constant = 0
            self?.layoutListRight.constant = 0
            self?.layoutListLeft.constant = 0
            
            UIView.animate(
                withDuration:
                listAnimationDuration,
                animations:
                { [weak self] in
                    
                    self?.layoutIfNeeded()
                    
                })
            { [weak self] (done:Bool) in
                
                self?.layoutBarTop.constant = 0
                self?.layoutListTop.constant = barHeight
                
                UIView.animate(
                    withDuration:
                    barAnimationDuration)
                    { [weak self] in
                        
                        self?.layoutIfNeeded()
                    }
            }
        }
    }
}
