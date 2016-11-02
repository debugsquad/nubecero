import UIKit

class VPicturesDataCellCreated:VPicturesDataCell
{
    private weak var labelDate:UILabel!
    private let kDateFormat:String = "MMMM-dd"
    private let kFontLabelTitle:CGFloat = 13
    private let kFontLabelDate:CGFloat = 16
    private let kLabelTitleTop:CGFloat = 20
    private let kLabelTitleHeight:CGFloat = 16
    private let kLabelDateTop:CGFloat = 10
    private let kLabelDateHeight:CGFloat = 20
    
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
        labelTitle.text = NSLocalizedString("VPicturesDataCellCreated_labelTitle", comment:"")
        
        let labelDate:UILabel = UILabel()
        labelDate.isUserInteractionEnabled = false
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.backgroundColor = UIColor.clear
        labelDate.textAlignment = NSTextAlignment.center
        labelDate.textColor = UIColor.complement
        labelDate.font = UIFont.numeric(size:kFontLabelDate)
        self.labelDate = labelDate
        
        addSubview(labelTitle)
        addSubview(labelDate)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelDate":labelDate]
        
        let metrics:[String:CGFloat] = [
            "labelTitleTop":kLabelTitleTop,
            "labelTitleHeight":kLabelTitleHeight,
            "labelDateTop":kLabelDateTop,
            "labelDateHeight":kLabelDateHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelDate]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(labelTitleTop)-[labelTitle(labelTitleHeight)]-(labelDateTop)-[labelDate(labelDateHeight)]",
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
        let timestamp:TimeInterval = controller.model.created
        let dateCreated:Date = Date(timeIntervalSince1970:timestamp)
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormat
        
        let dateString:String = dateFormatter.string(from:dateCreated)
        labelDate.text = dateString
    }
}
