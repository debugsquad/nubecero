import UIKit

class VStoreAd:UIView
{
    private weak var controller:CStoreAd!
    private weak var layoutBaseLeft:NSLayoutConstraint!
    private weak var layoutBaseTop:NSLayoutConstraint!
    private let kBaseWidth:CGFloat = 300
    private let kBaseHeight:CGFloat = 350
    private let kButtonHeight:CGFloat = 42
    private let kCornerRadius:CGFloat = 12
    
    convenience init(controller:CStoreAd)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonWidth:CGFloat = kBaseWidth / 2.0
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = controller.model.image
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.main
        labelTitle.font = UIFont.medium(size:22)
        labelTitle.text = controller.model.title
        
        let labelDescr:UILabel = UILabel()
        labelDescr.isUserInteractionEnabled = false
        labelDescr.translatesAutoresizingMaskIntoConstraints = false
        labelDescr.backgroundColor = UIColor.clear
        labelDescr.textAlignment = NSTextAlignment.center
        labelDescr.textColor = UIColor.black
        labelDescr.font = UIFont.regular(size:18)
        labelDescr.numberOfLines = 0
        labelDescr.text = controller.model.descr
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.backgroundColor = UIColor.white
        baseView.layer.borderWidth = 1
        baseView.layer.borderColor = UIColor(white:0, alpha:0.5).cgColor
        baseView.layer.cornerRadius = kCornerRadius
        
        let buttonAccept:UIButton = UIButton()
        buttonAccept.backgroundColor = UIColor.complement
        buttonAccept.clipsToBounds = true
        buttonAccept.translatesAutoresizingMaskIntoConstraints = false
        buttonAccept.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonAccept.setTitleColor(
            UIColor(white:1, alpha:0.3),
            for:UIControlState.highlighted)
        buttonAccept.setTitle(
            NSLocalizedString("VStoreAd_buttonAccept", comment:""),
            for:UIControlState.normal)
        buttonAccept.titleLabel!.font = UIFont.medium(size:13)
        buttonAccept.addTarget(
            self,
            action:#selector(actionAccept(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.backgroundColor = UIColor.red
        buttonCancel.clipsToBounds = true
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.3),
            for:UIControlState.highlighted)
        buttonCancel.setTitle(
            NSLocalizedString("VStoreAd_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.titleLabel!.font = UIFont.medium(size:13)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        baseView.addSubview(imageView)
        baseView.addSubview(labelTitle)
        baseView.addSubview(labelDescr)
        baseView.addSubview(buttonCancel)
        baseView.addSubview(buttonAccept)
        addSubview(visualEffect)
        addSubview(baseView)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "labelTitle":labelTitle,
            "labelDescr":labelDescr,
            "visualEffect":visualEffect,
            "baseView":baseView,
            "buttonAccept":buttonAccept,
            "buttonCancel":buttonCancel]
        
        let metrics:[String:CGFloat] = [
            "baseWidth":kBaseWidth,
            "baseHeight":kBaseHeight,
            "buttonHeight":kButtonHeight,
            "buttonWidth":buttonWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelDescr]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[baseView(baseWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[buttonCancel(buttonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonAccept(buttonWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[labelTitle(30)]-0-[labelDescr(140)]-0-[imageView(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[baseView(baseHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonAccept(buttonHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonCancel(buttonHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBaseLeft = NSLayoutConstraint(
            item:baseView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        layoutBaseTop = NSLayoutConstraint(
            item:baseView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBaseLeft)
        addConstraint(layoutBaseTop)
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainWidth:CGFloat = width - kBaseWidth
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat
        
        if height > kBaseHeight
        {
            let remainHeight:CGFloat = height - kBaseHeight
            marginTop = remainHeight / 2.0
        }
        else
        {
            marginTop = height - (kBaseHeight + kButtonHeight)
        }
        
        layoutBaseTop.constant = marginTop
        layoutBaseLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
    
    func actionAccept(sender button:UIButton)
    {
        controller.accept()
    }
}
