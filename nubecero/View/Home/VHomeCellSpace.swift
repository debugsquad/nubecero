import UIKit

class VHomeCellSpace:VHomeCell
{
    weak var labelTotalSpace:UILabel!
    weak var labelUsedSpace:UILabel!
    private let kFontTitleSize:CGFloat = 14
    private let kFontUsedSpaceSize:CGFloat = 24
    private let kFontTotalSpaceSize:CGFloat = 20
    private let kSeparatorHeight:CGFloat = 1
    private let kSeparatorWidth:CGFloat = 100
    private let kLabelsTop:CGFloat = 10
    private let kLabelsLeft:CGFloat = 10
    private let kLabelsWidth:CGFloat = 250
    private let kLabelTitleHeight:CGFloat = 18
    private let kLabelTotalSpaceHeight:CGFloat = 25
    private let kLabelUsedSpaceHeight:CGFloat = 30
    
    override init(frame:CGRect)
    {
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
        
        let labelTotalSpace:UILabel = UILabel()
        labelTotalSpace.isUserInteractionEnabled = false
        labelTotalSpace.translatesAutoresizingMaskIntoConstraints = false
        labelTotalSpace.backgroundColor = UIColor.clear
        labelTotalSpace.font = UIFont.numeric(size:kFontTotalSpaceSize)
        labelTotalSpace.textColor = UIColor.complement
        self.labelTotalSpace = labelTotalSpace
        
        let labelUsedSpace:UILabel = UILabel()
        labelUsedSpace.isUserInteractionEnabled = false
        labelUsedSpace.translatesAutoresizingMaskIntoConstraints = false
        labelUsedSpace.backgroundColor = UIColor.clear
        labelUsedSpace.font = UIFont.numeric(size:kFontUsedSpaceSize)
        labelUsedSpace.textColor = UIColor.main
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
            "separatorWidth":kSeparatorWidth,
            "separatorHeight":kSeparatorHeight,
            "labelsLeft":kLabelsLeft,
            "labelsWidth":kLabelsWidth,
            "labelTitleHeight":kLabelTitleHeight,
            "labelTotalSpaceHeight":kLabelTotalSpaceHeight,
            "labelUsedSpaceHeight":kLabelUsedSpaceHeight,
            "labelsTop":kLabelsTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(labelsLeft)-[labelTitle(labelsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(labelsLeft)-[labelTotalSpace(labelsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(labelsLeft)-[labelUsedSpace(labelsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(labelsLeft)-[separator(separatorWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(labelsTop)-[labelTitle(labelTitleHeight)]-0-[labelUsedSpace(labelUsedSpaceHeight)]-0-[labelTotalSpace(labelTotalSpaceHeight)]",
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
        
    }
}
