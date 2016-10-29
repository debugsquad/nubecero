import UIKit

class VHomeUploadCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var base:UIView!
    private let kImageMargin:CGFloat = 5
    private let kCornerRadius:CGFloat = 4
    
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
        self.base = base
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = kCornerRadius
        self.imageView = imageView
        
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "imageMargin":kImageMargin]
        
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
        }
        else
        {
        }
    }
    
    //MARK: public
    
    func config(model:MHomeUploadItem)
    {
        imageView.image = model.image
    }
}
