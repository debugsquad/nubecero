import UIKit

class VHomeUploadSyncCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var layoutImageViewWidth:NSLayoutConstraint!
    private let kImageViewLeft:CGFloat = 5
    private let kImageViewRight:CGFloat = 5
    private let kImageViewMarginVertical:CGFloat = 2
    private let compoundMarginVertical:CGFloat
    
    override init(frame:CGRect)
    {
        compoundMarginVertical = kImageViewMarginVertical + kImageViewMarginVertical
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.3)
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "imageViewLeft":kImageViewLeft,
            "imageViewRight":kImageViewRight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(imageViewLeft)-[imageView]-(imageViewRight)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(imageViewMarginVertical)-[imageView]-(imageViewMarginVertical)-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutImageViewWidth = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutImageViewWidth)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let height_margin:CGFloat = height - compoundMarginVertical
        let cornerRadius:CGFloat = height_margin / 2.0
        layoutImageViewWidth.constant = height_margin
        imageView.layer.cornerRadius = cornerRadius
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MHomeUploadItem)
    {
        imageView.image = model.image
    }
}
