import UIKit

class VHomeUploadHeaderCell:UICollectionViewCell
{
    private weak var circle:UIView!
    private weak var imageView:UIImageView!
    private weak var title:UILabel!
    private weak var layoutCircleLeft:NSLayoutConstraint!
    private let kCircleSize:CGFloat = 80
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let circle:UIView = UIView()
        circle.isUserInteractionEnabled = false
        circle.clipsToBounds = true
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = kCircleSize / 2.0
        self.circle = circle
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        let title:UILabel = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.isUserInteractionEnabled = false
        title.font = UIFont.regular(size:13)
        title.textColor = UIColor(white:0.3, alpha:1)
        title.textAlignment = NSTextAlignment.center
        self.title = title
        
        circle.addSubview(imageView)
        addSubview(circle)
        addSubview(title)
        
        let views:[String:UIView] = [
            "circle":circle,
            "imageView":imageView,
            "title":title]
        
        let metrics:[String:CGFloat] = [
            "circleSize":kCircleSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[title]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[circle(circleSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[title(20)]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[circle(circleSize)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutCircleLeft = NSLayoutConstraint(
            item:circle,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutCircleLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainWidth:CGFloat = width - kCircleSize
        let margin:CGFloat = remainWidth / 2.0
        layoutCircleLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MHomeUploadHeaderItem)
    {
        imageView.image = model.image
        circle.backgroundColor = model.color
        title.text = model.title
    }
}
