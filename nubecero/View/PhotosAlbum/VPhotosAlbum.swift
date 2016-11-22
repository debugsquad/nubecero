import UIKit

class VPhotosAlbum:UIView
{
    private weak var controller:CPhotosAlbum!
    private weak var backButton:UIButton!
    private weak var collectionView:UICollectionView!
    private weak var layoutBackgroundTop:NSLayoutConstraint!
    private weak var layoutBackButtonTop:NSLayoutConstraint!
    private let kLineSpacing:CGFloat = 1
    private let kCollectionTop:CGFloat = 180
    private let kCollectionBottom:CGFloat = 20
    
    convenience init(controller:CPhotosAlbum)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let leftBorder:UIView = UIView()
        leftBorder.isUserInteractionEnabled = false
        leftBorder.translatesAutoresizingMaskIntoConstraints = false
        leftBorder.backgroundColor = UIColor.black
        
        let background:UIView = UIView()
        background.clipsToBounds = true
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = UIColor.white
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor.black
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        self.backButton = backButton
        
        let albumTitle:VPhotosAlbumTitle = VPhotosAlbumTitle(controller:controller)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = kLineSpacing
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        
        addSubview(background)
        addSubview(leftBorder)
        addSubview(albumTitle)
        addSubview(backButton)
        
        let views:[String:UIView] = [
            "background":background,
            "backButton":backButton,
            "leftBorder":leftBorder,
            "albumTitle":albumTitle]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[leftBorder(1)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[albumTitle]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[backButton(44)]-0-[albumTitle]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[leftBorder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[background]-0-|",
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
        
        layoutBackgroundTop = NSLayoutConstraint(
            item:background,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kCollectionTop)
        
        addConstraint(layoutBackButtonTop)
        addConstraint(layoutBackgroundTop)
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
