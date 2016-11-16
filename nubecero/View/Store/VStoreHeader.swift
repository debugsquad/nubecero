import UIKit

class VStoreHeader:UICollectionReusableView
{
    private let attrTitle:[String:Any]
    private let attrDescr:[String:Any]
    private let labelMargins:CGFloat
    private weak var label:UILabel!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let kLabelMarginHorizontal:CGFloat = 10
    
    override init(frame:CGRect)
    {
        attrTitle = [
            NSFontAttributeName:UIFont.bold(size:17),
            NSForegroundColorAttributeName:UIColor.main
        ]
        
        attrDescr = [
            NSFontAttributeName:UIFont.medium(size:17),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)
        ]
        
        labelMargins = kLabelMarginHorizontal + kLabelMarginHorizontal
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.label = label
        
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label]
        
        let metrics:[String:CGFloat] = [
            "labelMarginHorizontal":kLabelMarginHorizontal]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(labelMargin)-[label]-(labelMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(labelMargin)-[label]",
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
        layoutLabelHeight.constant = boundingRect.size.height
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MStoreItem)
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.purchaseTitle,
            attributes:attrTitle)
        let stringDescr:NSAttributedString = NSAttributedString(
            string:model.purchaseDescription,
            attributes:attrDescr)
        mutableString.append(stringTitle)
        mutableString.append(stringDescr)
        
        label.attributedText = mutableString
        
        setNeedsLayout()
    }
}
