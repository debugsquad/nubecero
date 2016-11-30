import UIKit
import FirebaseAuth

class VLogin:UIView
{
    private weak var controller:CLogin!
    private weak var layoutBaseTop:NSLayoutConstraint!
    private let kBaseHeight:CGFloat = 90
    private let kLogoHeight:CGFloat = 70
    private let kTextHeight:CGFloat = 25
    
    convenience init(controller:CLogin)
    {
        self.init()
        isUserInteractionEnabled = false
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.main
        self.controller = controller
        
        let base:UIView = UIView()
        base.isUserInteractionEnabled = false
        base.translatesAutoresizingMaskIntoConstraints = false
        base.backgroundColor = UIColor.clear
        
        let logoView:UIImageView = UIImageView()
        logoView.isUserInteractionEnabled = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.clipsToBounds = true
        logoView.contentMode = UIViewContentMode.center
        logoView.image = #imageLiteral(resourceName: "assetGenericLogo")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:18)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = NSLocalizedString("VLogin_label", comment:"")
        
        base.addSubview(logoView)
        base.addSubview(label)
        addSubview(base)
        
        let views:[String:UIView] = [
            "logoView":logoView,
            "label":label,
            "base":base]
        
        let metrics:[String:CGFloat] = [
            "baseHeight":kBaseHeight,
            "logoHeight":kLogoHeight,
            "textHeight":kTextHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[label(textHeight)]-5-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[logoView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[logoView(logoHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[base]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[base(baseHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBaseTop = NSLayoutConstraint(
            item:base,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBaseTop)
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remain:CGFloat = height - kBaseHeight
        let margin:CGFloat = remain / 2.0
        layoutBaseTop.constant = margin
        
        super.layoutSubviews()
    }
}
