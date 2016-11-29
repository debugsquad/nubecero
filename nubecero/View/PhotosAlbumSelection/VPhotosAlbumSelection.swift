import UIKit

class VPhotosAlbumSelection:UIView
{
    private weak var controller:CPhotosAlbumSelection!
    private weak var collectionView:UICollectionView!
    private weak var layoutButtonCancelLeft:NSLayoutConstraint!
    private let kButtonCancelWidth:CGFloat = 120
    
    convenience init(controller:CPhotosAlbumSelection)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.isUserInteractionEnabled = false
        visualEffect.clipsToBounds = true
        
        let vibrancyEffect:UIVibrancyEffect = UIVibrancyEffect(blurEffect:blurEffect)
        let vibrancyVisual:UIVisualEffectView = UIVisualEffectView(effect:vibrancyEffect)
        vibrancyVisual.translatesAutoresizingMaskIntoConstraints = false
        vibrancyVisual.isUserInteractionEnabled = false
        vibrancyVisual.clipsToBounds = true
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.medium(size:22)
        labelTitle.textColor = UIColor.black
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.text = NSLocalizedString("VPhotosAlbumSelection_labelTitle", comment:"")
        
        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.backgroundColor = UIColor.white
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0, alpha:0.3),
            for:UIControlState.highlighted)
        buttonCancel.setTitle(
            NSLocalizedString("VPhotosAlbumSelection_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.titleLabel!.font = UIFont.medium(size:16)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        vibrancyVisual.contentView.addSubview(labelTitle)
        visualEffect.contentView.addSubview(vibrancyVisual)
        addSubview(visualEffect)
        addSubview(buttonCancel)

        let views:[String:UIView] = [
            "background":background,
            "buttonCancel":buttonCancel,
            "visualEffect":visualEffect,
            "vibrancyVisual":vibrancyVisual,
            "labelTitle":labelTitle]
        
        let metrics:[String:CGFloat] = [
            "buttonCancelWidth":kButtonCancelWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonCancel(buttonCancelWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[vibrancyVisual]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonCancel(40)]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[vibrancyVisual]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-65-[labelTitle(30)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-120-[background]-120-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonCancelLeft = NSLayoutConstraint(
            item:buttonCancel,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonCancelLeft)
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonCancelWidth
        let margin:CGFloat = remain / 2.0
        
        layoutButtonCancelLeft.constant = margin
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
}
