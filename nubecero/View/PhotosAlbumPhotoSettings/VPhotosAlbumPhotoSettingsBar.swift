import UIKit

class VPhotosAlbumPhotoSettingsBar:UIView
{
    private weak var controller:CPhotosAlbumPhotoSettings!
    
    convenience init(controller:CPhotosAlbumPhotoSettings)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor.black
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let deleteButton:UIButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setImage(
            #imageLiteral(resourceName: "assetPhotosDelete").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        deleteButton.setImage(
            #imageLiteral(resourceName: "assetPhotosDelete").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        deleteButton.imageView!.tintColor = UIColor.main
        deleteButton.imageView!.clipsToBounds = true
        deleteButton.imageView!.contentMode = UIViewContentMode.center
        deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0)
        deleteButton.addTarget(
            self,
            action:#selector(actionDelete(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(deleteButton)
        addSubview(backButton)
        
        let views:[String:UIView] = [
            "backButton":backButton,
            "deleteButton":deleteButton]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[deleteButton(60)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[backButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[deleteButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionDelete(sender button:UIButton)
    {
        controller.deletePhoto()
    }
}
