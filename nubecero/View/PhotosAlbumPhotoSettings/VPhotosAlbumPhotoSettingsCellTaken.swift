import UIKit

class VPhotosAlbumPhotoSettingsCellTaken:VPhotosAlbumPhotoSettingsCell
{
    private weak var labelDate:UILabel!
    private let dateFormatter:DateFormatter
    private let kNoDate:String = "-"
    
    override init(frame:CGRect)
    {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        
        super.init(frame:frame)
        backgroundColor = UIColor.white
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:14)
        labelTitle.textColor = UIColor.complement
        labelTitle.text = NSLocalizedString("VPhotosAlbumPhotoSettingsCellTaken_labelTitle", comment:"")
        
        let labelDate:UILabel = UILabel()
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.isUserInteractionEnabled = false
        labelDate.backgroundColor = UIColor.clear
        labelDate.font = UIFont.regular(size:17)
        labelDate.textColor = UIColor.black
        self.labelDate = labelDate
        
        addSubview(labelTitle)
        addSubview(labelDate)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelDate":labelDate]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelTitle(65)]-0-[labelDate(250)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelDate]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CPhotosAlbumPhotoSettings, model:MPhotosAlbumPhotoSettingsItem)
    {
        super.config(controller:controller, model:model)
        
        guard
            
            let taken:TimeInterval = controller.photo?.taken
            
        else
        {
            return
        }
        
        if taken > 0
        {
            let date:Date = Date(timeIntervalSince1970:taken)
            let takenString:String = dateFormatter.string(from:date)
            labelDate.text = takenString
        }
        else
        {
            labelDate.text = kNoDate
        }
    }
}
