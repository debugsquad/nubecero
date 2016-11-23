import UIKit

class VPhotosCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var labelSize:UILabel!
    private weak var layoutRightWidth:NSLayoutConstraint!
    private let attributesName:[String:AnyObject]
    private let attributesCount:[String:AnyObject]
    private let attributesSize:[String:AnyObject]
    private let boundingRect:CGSize
    private let drawingOptions:NSStringDrawingOptions
    private let numberFormatter:NumberFormatter
    private let kAnimateAfter:TimeInterval = 0.05
    private let kAnimationDuration:TimeInterval = 0.3
    private let kBoundingRectWidth:CGFloat = 500
    private let kLabelSizeLeft:CGFloat = 10
    private let kLabelSizeRight:CGFloat = 30
    private let kAlphaSelected:CGFloat = 0.3
    private let kAlphaNotSelected:CGFloat = 1
    private let kKiloBytesPerMega:CGFloat = 1000
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        attributesName = [
            NSFontAttributeName:UIFont.regular(size:17),
            NSForegroundColorAttributeName:UIColor(white:0.25, alpha:1)
        ]
        
        attributesCount = [
            NSFontAttributeName:UIFont.regular(size:12),
            NSForegroundColorAttributeName:UIColor(white:0.45, alpha:1)
        ]
        
        attributesSize = [
            NSFontAttributeName:UIFont.medium(size:13)
        ]
        
        boundingRect = CGSize(width:kBoundingRectWidth, height:frame.size.height)
        drawingOptions = NSStringDrawingOptions([
                NSStringDrawingOptions.usesFontLeading,
                NSStringDrawingOptions.usesLineFragmentOrigin
            ])
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        self.label = label
        
        let labelSize:UILabel = UILabel()
        labelSize.isUserInteractionEnabled = false
        labelSize.translatesAutoresizingMaskIntoConstraints = false
        labelSize.backgroundColor = UIColor.clear
        labelSize.textColor = UIColor.white
        self.labelSize = labelSize
        
        let leftView:UIView = UIView()
        leftView.isUserInteractionEnabled = false
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.clipsToBounds = true
        leftView.backgroundColor = UIColor.white
        
        let rightView:UIView = UIView()
        rightView.isUserInteractionEnabled = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.clipsToBounds = true
        rightView.backgroundColor = UIColor.complement
        
        rightView.addSubview(labelSize)
        leftView.addSubview(label)
        addSubview(rightView)
        addSubview(leftView)
        
        let views:[String:UIView] = [
            "label":label,
            "rightView":rightView,
            "leftView":leftView,
            "labelSize":labelSize]
        
        let metrics:[String:CGFloat] = [
            "labelSizeLeft":kLabelSizeLeft]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-2-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelSize(150)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[leftView]-0-[rightView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[leftView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[rightView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelSize]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutRightWidth = NSLayoutConstraint(
            item:rightView,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutRightWidth)
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
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MPhotosItem)
    {
        hover()
        
        let count:NSNumber = model.references.count as NSNumber
        let megaBytesFloat:CGFloat = CGFloat(model.kiloBytes) / kKiloBytesPerMega
        let megaBytes:NSNumber = megaBytesFloat as NSNumber
        
        guard
            
            let countString:String = numberFormatter.string(from:count),
            let megaBytesString:String = numberFormatter.string(from:megaBytes)
        
        else
        {
            return
        }
        
        let compositeString:String = String(
            format:NSLocalizedString("VPhotosCell_labelPhotos", comment:""),
            countString)
        let compositeStringSize:String = String(
            format:NSLocalizedString("VPhotosCell_labelSize", comment:""),
            megaBytesString)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringName:NSAttributedString = NSAttributedString(
            string:model.name,
            attributes:attributesName)
        let stringCount:NSAttributedString = NSAttributedString(
            string:compositeString,
            attributes:attributesCount)
        mutableString.append(stringName)
        mutableString.append(stringCount)
        
        let attrCompositeSize:NSAttributedString = NSAttributedString(
            string:compositeStringSize,
            attributes:attributesSize)
        
        label.attributedText = mutableString
        labelSize.attributedText = attrCompositeSize
        
        let labelWidth:CGFloat = ceil(attrCompositeSize.boundingRect(
            with:boundingRect,
            options:drawingOptions,
            context:nil).width)
        let labelMarginWidth:CGFloat = labelWidth + kLabelSizeLeft + kLabelSizeRight
        layoutRightWidth.constant = 0
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAnimateAfter)
        { [weak self] in
            
            guard
                
                let animationDuration:TimeInterval = self?.kAnimationDuration
            
            else
            {
                return
            }
            
            self?.layoutRightWidth.constant = labelMarginWidth
            
            UIView.animate(withDuration:animationDuration)
            { [weak self] in
                
                self?.layoutIfNeeded()
            }
        }
    }
}
