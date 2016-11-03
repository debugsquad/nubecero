import UIKit

class VBanned:UIView
{
    weak var controller:CBanned!
    private let kLabelMargin:CGFloat = 20
    private let kLabelHeight:CGFloat = 120
    
    convenience init(controller:CBanned)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.main
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericLogo")
        
        let labelView:UILabel = UILabel()
        labelView.isUserInteractionEnabled = false
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.backgroundColor = UIColor.clear
        labelView.numberOfLines = 0
        labelView.textAlignment = NSTextAlignment.center
        labelView.font = UIFont.medium(size:18)
        labelView.text = NSLocalizedString("VBanned_disclaimer", comment:"")
        
        addSubview(imageView)
        addSubview(labelView)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "labelView":labelView]
        
        let metrics:[String:CGFloat] = [
            "labelHeight":kLabelHeight,
            "labelMargin":kLabelMargin]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(labelMargin)-[labelView]-(labelMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelView(labelHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
