import UIKit

class VPicturesDataCellCreated:VPicturesDataCell
{
    private weak var labelDate:UILabel!
    
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
        labelTitle.text = NSLocalizedString("VPicturesDataCellCreated_labelTitle", comment:"")
        
        let labelDate:UILabel = UILabel()
        labelDate.isUserInteractionEnabled = false
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.backgroundColor = UIColor.clear
        labelDate.textAlignment = NSTextAlignment.center
        labelDate.textColor = UIColor.main
        labelDate.numberOfLines = 2
        labelDate.font = UIFont.bold(size:16)
        self.labelDate = labelDate
        
        addSubview(labelTitle)
        addSubview(labelDate)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelDate":labelDate]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-5-[labelDate]-5-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelTitle(20)]-0-[labelDate(28)]",
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
        dateFormatter.dateStyle = DateFormatter.Style.long
        
        let dateString:String = dateFormatter.string(from:dateCreated)
        labelDate.text = dateString
    }
}
