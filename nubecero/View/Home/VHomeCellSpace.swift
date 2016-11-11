import UIKit

class VHomeCellSpace:VHomeCell
{
    weak var label:UILabel!
    let numberFormatter:NumberFormatter
    let kEmpty:String = ""
    let kKilobytesPerMega:CGFloat = 1000
    private weak var layoutIndicatorTop:NSLayoutConstraint!
    private let kMaxFractions:Int = 1
    private let kIndicatorSize:CGFloat = 8
    private let kCornerRadius:CGFloat = 4
    
    init(frame:CGRect, color:UIColor)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxFractions
        
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let indicator:UIView = UIView()
        indicator.isUserInteractionEnabled = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = color
        indicator.layer.cornerRadius = kCornerRadius
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:14)
        label.textColor = UIColor.black
        self.label = label
        
        let views:[String:UIView] = [
            "label":label,
            "indicator":indicator]
        
        let metrics:[String:CGFloat] = [
            "indicatorSize":kIndicatorSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[indicator(indicatorSize)]-5-[label(280)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[indicator(indicatorSize)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutIndicatorTop = NSLayoutConstraint(
            item:indicator,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutIndicatorTop)
    }
    
    override init(frame:CGRect)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remain:CGFloat = height - kIndicatorSize
        let margin:CGFloat = remain / 2.0
        layoutIndicatorTop.constant = margin
        
        super.layoutSubviews()
    }
}
