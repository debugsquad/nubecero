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
            NSFontAttributeName:UIFont.regular(size:16),
            NSForegroundColorAttributeName:UIColor(white:0.3, alpha:1)
        ]
        
        attributesCount = [
            NSFontAttributeName:UIFont.regular(size:12),
            NSForegroundColorAttributeName:UIColor(white:0.6, alpha:1)
        ]
        
        super.init(frame:frame)
        clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        self.label = label
        
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[label]-0-|",
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
            backgroundColor = UIColor.clear
            alpha = kAlphaSelected
        }
        else
        {
            backgroundColor = UIColor.white
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
            format:"\n%@ Photos  ■  %@ Mb",
            countString,
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
        
        label.attributedText = mutableString
    }
}
