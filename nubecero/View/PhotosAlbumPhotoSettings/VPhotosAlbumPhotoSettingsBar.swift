import UIKit

class VPhotosAlbumPhotoSettingsBar:UIView
{
    private weak var controller:CPhotosAlbumPhotoSettings!
    private weak var imageView:UIImageView!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var layoutImageTop:NSLayoutConstraint!
    private let kImageSize:CGFloat = 80
    private let kStatusBarHeight:CGFloat = 20
    
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
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(white:0, alpha:0.5).cgColor
        imageView.layer.cornerRadius = kImageSize / 2.0
        imageView.image = controller.photo?.state?.loadImage()
        self.imageView = imageView
        
        addSubview(deleteButton)
        addSubview(backButton)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "backButton":backButton,
            "deleteButton":deleteButton,
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "imageSize":kImageSize]
        
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
            withVisualFormat:"H:[imageView(imageSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[backButton(44)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[deleteButton(44)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[imageView(imageSize)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutImageLeft = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        layoutImageTop = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutImageLeft)
        addConstraint(layoutImageTop)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY - kStatusBarHeight
        let remainWidth:CGFloat = width - kImageSize
        let remainHeight:CGFloat = height - kImageSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutImageLeft.constant = marginLeft
        layoutImageTop.constant = marginTop + kStatusBarHeight
        super.layoutSubviews()
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
