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
        
        addSubview(visualEffect)
        addSubview(baseView)
        
        let views:[String:UIView] = [
            "visualEffect":visualEffect,
            "baseView":baseView]
        
        let metrics:[String:CGFloat] = [
            "baseWidth":kBaseWidth,
            "baseHeight":kBaseHeight,
            "buttonHeight":kButtonHeight]
        
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
            withVisualFormat:"V:[baseHeight(baseHeight)]",
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
}
