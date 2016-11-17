import UIKit

class VStoreHeader:UICollectionReusableView
{
    private let attrTitle:[String:Any]
    private let attrDescr:[String:Any]
    private let labelMargins:CGFloat
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let kLabelMarginHorizontal:CGFloat = 20
    private let kImageViewSize:CGFloat = 100
    
    override init(frame:CGRect)
    {
        attrTitle = [
            NSFontAttributeName:UIFont.medium(size:18),
            NSForegroundColorAttributeName:UIColor.main
        ]
        
        attrDescr = [
            NSFontAttributeName:UIFont.regular(size:18),
            NSForegroundColorAttributeName:UIColor.black
        ]
        
        labelMargins = kLabelMarginHorizontal + kImageViewSize
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.label = label
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "label":label,
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "labelMarginHorizontal":kLabelMarginHorizontal,
            "imageViewSize":kImageViewSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView(imageViewSize)]-0-[label]-(labelMarginHorizontal)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-22-[label]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView(imageViewSize)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutLabelHeight = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutLabelHeight)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        guard
            
            let attributedText:NSAttributedString = label.attributedText
        
        else
        {
            return
        }
        
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let usableWidth:CGFloat = width - labelMargins
        let usableSize:CGSize = CGSize(width:usableWidth, height:height)
        let boundingRect:CGRect = attributedText.boundingRect(
            with:usableSize,
            options:NSStringDrawingOptions([
                NSStringDrawingOptions.usesLineFragmentOrigin,
                NSStringDrawingOptions.usesFontLeading
                ]),
            context:nil)
        layoutLabelHeight.constant = ceil(boundingRect.size.height)
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MStoreItem)
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.title,
            attributes:attrTitle)
        let stringDescr:NSAttributedString = NSAttributedString(
            string:model.descr,
            attributes:attrDescr)
        mutableString.append(stringTitle)
        mutableString.append(stringDescr)
        
        label.attributedText = mutableString
        imageView.image = model.image
        
        setNeedsLayout()
    }
}
