import UIKit

class VHomeCellSpace:VHomeCell
{
    private let numberFormatter:NumberFormatter
    private weak var labelTotalSpace:UILabel!
    private weak var labelUsedSpace:UILabel!
    private let kEmpty:String = ""
    private let kMaxFractions:Int = 1
    private let kFontTitleSize:CGFloat = 15
    private let kFontUsedSpaceSize:CGFloat = 50
    private let kFontTotalSpaceSize:CGFloat = 20
    private let kSeparatorHeight:CGFloat = 1
    private let kSeparatorMargin:CGFloat = 120
    private let kLabelsTop:CGFloat = 10
    private let kLabelTitleHeight:CGFloat = 40
    private let kLabelTotalSpaceHeight:CGFloat = 25
    private let kLabelUsedSpaceHeight:CGFloat = 60
    private let kKilobytesPerMega:CGFloat = 1000
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxFractions
        
        super.init(frame:frame)
        
        let separator:UIView = UIView()
        separator.isUserInteractionEnabled = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.complement
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:kFontTitleSize)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VHomeCellSpace_labelTitle", comment:"")
        labelTitle.textAlignment = NSTextAlignment.center
        
        let labelTotalSpace:UILabel = UILabel()
        labelTotalSpace.isUserInteractionEnabled = false
        labelTotalSpace.translatesAutoresizingMaskIntoConstraints = false
        labelTotalSpace.backgroundColor = UIColor.clear
        labelTotalSpace.font = UIFont.numeric(size:kFontTotalSpaceSize)
        labelTotalSpace.textColor = UIColor.complement
        labelTotalSpace.textAlignment = NSTextAlignment.center
        self.labelTotalSpace = labelTotalSpace
        
        let labelUsedSpace:UILabel = UILabel()
        labelUsedSpace.isUserInteractionEnabled = false
        labelUsedSpace.translatesAutoresizingMaskIntoConstraints = false
        labelUsedSpace.backgroundColor = UIColor.clear
        labelUsedSpace.font = UIFont.numeric(size:kFontUsedSpaceSize)
        labelUsedSpace.textColor = UIColor.main
        labelUsedSpace.textAlignment = NSTextAlignment.center
        self.labelUsedSpace = labelUsedSpace
        
        addSubview(labelTotalSpace)
        addSubview(labelUsedSpace)
        addSubview(labelTitle)
        addSubview(separator)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "separator":separator,
            "labelTotalSpace":labelTotalSpace,
            "labelUsedSpace":labelUsedSpace]
        
        let metrics:[String:CGFloat] = [
            "separatorHeight":kSeparatorHeight,
            "separatorMargin":kSeparatorMargin,
            "labelTitleHeight":kLabelTitleHeight,
            "labelTotalSpaceHeight":kLabelTotalSpaceHeight,
            "labelUsedSpaceHeight":kLabelUsedSpaceHeight,
            "labelsTop":kLabelsTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle(labelsWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTotalSpace(labelsWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelUsedSpace(labelsWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(separatorMargin)-[separator(separatorWidth)]-(separatorMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(labelsTop)-[labelTitle(labelTitleHeight)]-0-[labelUsedSpace(labelUsedSpaceHeight)]-0-[separator(separatorHeight)]-0-[labelTotalSpace(labelTotalSpaceHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CHome, model:MHomeItem)
    {
        guard
        
            let usedSpaceInt:Int = controller.diskUsed,
            let totalSpaceInt:Int = MSession.sharedInstance.server?.froobSpace
        
        else
        {
            labelUsedSpace.text = kEmpty
            labelTotalSpace.text = kEmpty
            
            return
        }
        
        let usedSpace:NSNumber = (CGFloat(usedSpaceInt) / kKilobytesPerMega) as NSNumber
        let totalSpace:NSNumber = (CGFloat(totalSpaceInt) / kKilobytesPerMega) as NSNumber
        let usedSpaceString:String? = numberFormatter.string(from:usedSpace)
        let totalSpaceString:String? =  numberFormatter.string(from:totalSpace)
        labelUsedSpace.text = usedSpaceString
        labelTotalSpace.text = totalSpaceString
    }
}
