import UIKit

class VPhotosAlbumPhotoSettings:UIView
{
    private weak var controller:CPhotosAlbumPhotoSettings!
    private weak var collectionView:UICollectionView!
    
    convenience init(controller:CPhotosAlbumPhotoSettings)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.red
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let bar:VPhotosAlbumPhotoSettingsBar = VPhotosAlbumPhotoSettingsBar(
            controller:controller)
        
        addSubview(bar)
        
        let views:[String:UIView] = [
            "bar":bar]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
}
