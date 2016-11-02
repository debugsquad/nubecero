import UIKit

class VPicturesDataCellCreate:VPicturesDataCell
{
    private weak var labelSize:UILabel!
    private let kFontLabelTitle:CGFloat = 13
    private let kFontLabelSize:CGFloat = 65
    private let kLabelTitleTop:CGFloat = 20
    private let kLabelTitleHeight:CGFloat = 16
    private let kLabelSizeTop:CGFloat = 0
    private let kLabelSizeHeight:CGFloat = 90
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
        labelTitle.font = UIFont.medium(size:kFontLabelTitle)
        labelTitle.text = NSLocalizedString("VPicturesDataCellSize_labelTitle", comment:"")
        
        let labelSize:UILabel = UILabel()
        labelSize.isUserInteractionEnabled = false
        labelSize.translatesAutoresizingMaskIntoConstraints = false
        labelSize.backgroundColor = UIColor.clear
        labelSize.textAlignment = NSTextAlignment.center
        labelSize.textColor = UIColor.main
        labelSize.font = UIFont.numeric(size:kFontLabelSize)
        self.labelSize = labelSize
        
        addSubview(labelTitle)
        addSubview(labelSize)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelSize":labelSize]
        
        let metrics:[String:CGFloat] = [
            "labelTitleTop":kLabelTitleTop,
            "labelTitleHeight":kLabelTitleHeight,
            "labelSizeTop":kLabelSizeTop,
            "labelSizeHeight":kLabelSizeHeight]
        
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
            withVisualFormat:"V:|-(labelTitleTop)-[labelTitle(labelTitleHeight)]-(labelSizeTop)-[labelSize(labelSizeHeight)]",
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
        
        let sizeString:String? = numberFormatter.string(from:sizeNumber)
        labelSize.text = sizeString
    }
}
