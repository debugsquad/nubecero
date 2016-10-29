import UIKit

class VHomeUploadCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var base:UIView!
    private let kImageMargin:CGFloat = 6
    private let kBaseMargin:CGFloat = 1
    private let kCornerRadius:CGFloat = 4
    private let kBorderWidth:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let base:UIView = UIView()
        base.isUserInteractionEnabled = false
        base.translatesAutoresizingMaskIntoConstraints = false
        base.clipsToBounds = true
        base.layer.cornerRadius = kCornerRadius
        base.layer.borderColor = UIColor(white:0, alpha:0.1).cgColor
        base.layer.borderWidth = kBorderWidth
        self.base = base
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = kCornerRadius
        imageView.layer.borderColor = UIColor(white:0, alpha:0.1).cgColor
        imageView.layer.borderWidth = kBorderWidth
        self.imageView = imageView
        
        addSubview(base)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "base":base]
        
        let metrics:[String:CGFloat] = [
            "imageMargin":kImageMargin,
            "baseMargin":kBaseMargin]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(imageMargin)-[imageView]-(imageMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(imageMargin)-[imageView]-(imageMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(baseMargin)-[base]-(baseMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(baseMargin)-[base]-(baseMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            base.backgroundColor = UIColor.complement
        }
        else
        {
            base.backgroundColor = UIColor.background
        }
    }
    
    //MARK: public
    
    func config(model:MHomeUploadItem)
    {
        imageView.image = model.image
        hover()
    }
}
