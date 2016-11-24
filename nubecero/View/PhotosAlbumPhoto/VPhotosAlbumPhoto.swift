import UIKit

class VPhotosAlbumPhoto:UIView
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var viewList:VPhotosAlbumPhotoList!
    private let kBackgroundAnimationDuration:TimeInterval = 0.05
    
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
            withVisualFormat:"V:|-0-[bar(barHeight)]-0-[viewList]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        UIView.animate(
            withDuration:kBackgroundAnimationDuration)
        {
            background.alpha = 1
        }
    }
}
