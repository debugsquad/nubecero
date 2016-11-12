import UIKit

class VPicturesDataCellSize:VPicturesDataCell
{
    private weak var labelSize:UILabel!
    private let kKbInMb:CGFloat = 1000
    private let kMaxFractionDigits:Int = 2
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.black
        labelTitle.font = UIFont.bold(size:14)
        labelTitle.text = NSLocalizedString("VPicturesDataCellSize_labelTitle", comment:"")
        
        let labelSize:UILabel = UILabel()
        labelSize.isUserInteractionEnabled = false
        labelSize.translatesAutoresizingMaskIntoConstraints = false
        labelSize.backgroundColor = UIColor.clear
        labelSize.textAlignment = NSTextAlignment.center
        self.labelSize = labelSize
        
        addSubview(labelTitle)
        addSubview(labelSize)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelSize":labelSize]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelSize]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(0)-[labelTitle(20)]-0-[labelSize(40)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CPicturesData, model:MPicturesDataItem)
    {
        let sizeKb:CGFloat = CGFloat(controller.model.size)
        let sizeMb:CGFloat = sizeKb / kKbInMb
        let sizeNumber:NSNumber = sizeMb as NSNumber
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxFractionDigits
        
        guard
            
            let sizeString:String = numberFormatter.string(from:sizeNumber)
        
        else
        {
            return
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        let attrSize:NSAttributedString = NSAttributedString(
            string:sizeString,
            attributes:[
                NSFontAttributeName:UIFont.numeric(size:34),
                NSForegroundColorAttributeName:UIColor.main
            ])
        
        let attrUnit:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VPicturesDataCellSize_labelMegabytes", comment:""),
            attributes:[
                NSFontAttributeName:UIFont.medium(size:18),
                NSForegroundColorAttributeName:UIColor.complement
            ])
        
        mutableString.append(attrSize)
        mutableString.append(attrUnit)
        labelSize.attributedText = mutableString
    }
}
