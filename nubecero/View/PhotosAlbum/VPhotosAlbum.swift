import UIKit

class VPhotosAlbum:UIView
{
    private weak var controller:CPhotosAlbum!
    private weak var backButton:UIButton!
    private weak var layoutBackgroundTop:NSLayoutConstraint!
    private weak var layoutBackButtonTop:NSLayoutConstraint!
    
    convenience init(controller:CPhotosAlbum)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
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
        self.backButton = backButton
        
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
            withVisualFormat:"V:[backButton(44)]-",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBackButtonTop = NSLayoutConstraint(
            item:backButton,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:20)
        
        addConstraint(layoutBackButtonTop)
    }
}
