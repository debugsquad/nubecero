import UIKit

class VHomeUploadSyncCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var imageStatus:UIImageView!
    private weak var layoutImageViewWidth:NSLayoutConstraint!
    private let kImageViewLeft:CGFloat = 5
    private let kImageViewRight:CGFloat = 5
    private let kStatusWidth:CGFloat = 50
    private let kImageViewMarginVertical:CGFloat = 5
    private let compoundMarginVertical:CGFloat
    private let kCornerRadius:CGFloat = 5
    
    override init(frame:CGRect)
    {
        compoundMarginVertical = kImageViewMarginVertical + kImageViewMarginVertical
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.3)
        isUserInteractionEnabled = false
        layer.cornerRadius = kCornerRadius
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(white:0, alpha:0.2).cgColor
        self.imageView = imageView
        
        let imageStatus:UIImageView = UIImageView()
        imageStatus.isUserInteractionEnabled = false
        imageStatus.translatesAutoresizingMaskIntoConstraints = false
        imageStatus.clipsToBounds = true
        imageStatus.contentMode = UIViewContentMode.center
        self.imageStatus = imageStatus
        
        addSubview(imageView)
        addSubview(imageStatus)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "imageStatus":imageStatus]
        
        let metrics:[String:CGFloat] = [
            "imageViewLeft":kImageViewLeft,
            "imageViewRight":kImageViewRight,
            "imageViewMarginVertical":kImageViewMarginVertical,
            "statusWidth":kStatusWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(imageViewLeft)-[imageView]-(imageViewRight)-[imageStatus(statusWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(imageViewMarginVertical)-[imageView]-(imageViewMarginVertical)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageStatus]-0-|",
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
        imageStatus.image = UIImage(
            named:model.status.assetSync)
    }
}
