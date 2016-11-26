import UIKit

class VPhotosAlbumBar:UIView
{
    weak var controller:CPhotosAlbum!
    
    convenience init(controller:CPhotosAlbum)
    {
        self.init()
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
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
        
        let optionsButton:UIButton = UIButton()
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.setImage(
            #imageLiteral(resourceName: "assetPhotosOptions").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        optionsButton.setImage(
            #imageLiteral(resourceName: "assetPhotosOptions").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        optionsButton.imageView!.clipsToBounds = true
        optionsButton.imageView!.contentMode = UIViewContentMode.center
        optionsButton.imageView!.tintColor = UIColor.black
        optionsButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        optionsButton.addTarget(
            self,
            action:#selector(actionOptions(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(backButton)
        addSubview(optionsButton)
        
        let views:[String:UIView] = [
            "backButton":backButton,
            "optionsButton":optionsButton]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[optionsButton(60)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[backButton(44)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[optionsButton(44)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionOptions(sender button:UIButton)
    {
        controller.options()
    }
}
