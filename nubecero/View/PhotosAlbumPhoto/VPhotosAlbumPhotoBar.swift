import UIKit

class VPhotosAlbumPhotoBar:UIView
{
    private weak var controller:CPhotosAlbumPhoto!
    
    convenience init(controller:CPhotosAlbumPhoto)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.4)
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor.black
        backButton.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 25)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(backButton)
        
        let views:[String:UIView] = [
            "backButton":backButton]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[backButton(64)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
