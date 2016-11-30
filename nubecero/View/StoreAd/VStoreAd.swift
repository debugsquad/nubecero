import UIKit

class VStoreAd:UIView
{
    private weak var controller:CStoreAd!
    private weak var layoutBaseLeft:NSLayoutConstraint!
    private weak var layoutBaseTop:NSLayoutConstraint!
    private let kBaseWidth:CGFloat = 300
    private let kBaseHeight:CGFloat = 420
    private let kButtonHeight:CGFloat = 38
    private let kCornerRadius:CGFloat = 10
    
    convenience init(controller:CStoreAd)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let buttonWidth:CGFloat = kBaseWidth / 2.0
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.backgroundColor = UIColor.white
        baseView.layer.borderWidth = 1
        baseView.layer.borderColor = UIColor(white:0, alpha:0.1).cgColor
        baseView.layer.cornerRadius = kCornerRadius
        
        let buttonAccept:UIButton = UIButton()
        buttonAccept.backgroundColor = UIColor.complement
        buttonAccept.clipsToBounds = true
        buttonAccept.translatesAutoresizingMaskIntoConstraints = false
        buttonAccept.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonAccept.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonAccept.setTitle(
            NSLocalizedString("VStoreAd_buttonAccept", comment:""),
            for:UIControlState.normal)
        buttonAccept.titleLabel!.font = UIFont.medium(size:13)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.backgroundColor = UIColor.red
        buttonCancel.clipsToBounds = true
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.setTitle(
            NSLocalizedString("VStoreAd_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.titleLabel!.font = UIFont.medium(size:13)
        
        addSubview(visualEffect)
        addSubview(baseView)
        addSubview(buttonCancel)
        addSubview(buttonAccept)
        
        let views:[String:UIView] = [
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
            withVisualFormat:"V:[baseHeight(baseHeight)]",
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
        let remainHeight:CGFloat = height - kBaseHeight
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutBaseLeft.constant = marginLeft
        layoutBaseTop.constant = marginTop
        
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
