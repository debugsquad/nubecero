import UIKit

class VPhotosAlbumPhotoListCellImage:UIScrollView
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var scrollView:UIScrollView!
    weak var imageView:UIImageView!
    
    convenience init(controller:CPhotosAlbumPhoto)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let scrollView:UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = UIColor.clear
        self.scrollView = scrollView
        
        let imageView:UIImageView = UIImageView(
            frame:controller.inRect)
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        scrollView.addSubview(imageView)
        addSubview(scrollView)
        
        let views:[String:UIView] = [
            "scrollView":scrollView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[scrollView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[scrollView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
