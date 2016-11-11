import UIKit

class VHomeCellUpload:VHomeCell
{
    private weak var layoutImageLeft:NSLayoutConstraint!
    private let kImageSize:CGFloat = 40
    private let kLabelWidth:CGFloat = 115
    private let kImageRight:CGFloat = 20
    private let labelImageWidth:CGFloat
    
    override init(frame:CGRect)
    {
        labelImageWidth = kLabelWidth + kImageSize
        
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:14)
        label.textColor = UIColor.complement
        label.text = NSLocalizedString("VHomeCellUpload_label", comment:"")
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "assetHomeUpload")
        
        addSubview(label)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "label":label,
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "imageSize":kImageSize,
            "labelWidth":kLabelWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[imageView(imageSize)]-3-[label(labelWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-2-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutImageLeft = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutImageLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.size.width
        let remain:CGFloat = width - labelImageWidth
        let margin:CGFloat = remain / 2.0
        layoutImageLeft.constant = margin + kImageRight
        
        super.layoutSubviews()
    }
}
