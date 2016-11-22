import UIKit

class VPhotosCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private let attributesName:[String:AnyObject]
    private let attributesCount:[String:AnyObject]
    private let numberFormatter:NumberFormatter
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
            NSForegroundColorAttributeName:UIColor(white:0.5, alpha:1)
        ]
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        self.label = label
        
        let leftView:UIView = UIView()
        leftView.isUserInteractionEnabled = false
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.clipsToBounds = true
        leftView.backgroundColor = UIColor.white
        
        let rightView:UIView = UIView()
        rightView.isUserInteractionEnabled = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.clipsToBounds = true
        rightView.backgroundColor = UIColor(white:0, alpha:0.07)
        
        leftView.addSubview(label)
        addSubview(rightView)
        addSubview(leftView)
        
        let views:[String:UIView] = [
            "label":label,
            "rightView":rightView,
            "leftView":leftView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-2-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[leftView]-0-[rightView(120)]-0-|",
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
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringName:NSAttributedString = NSAttributedString(
            string:model.name,
            attributes:attributesName)
        let stringCount:NSAttributedString = NSAttributedString(
            string:compositeString,
            attributes:attributesCount)
        mutableString.append(stringName)
        mutableString.append(stringCount)
        
        label.attributedText = mutableString
    }
}
