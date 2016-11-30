import UIKit

class VPhotosAlbumPhotoSettingsCellAdded:VPhotosAlbumPhotoSettingsCell
{
    private weak var labelDate:UILabel!
    private let dateFormatter:DateFormatter
    
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
        labelTitle.text = NSLocalizedString("VPhotosAlbumPhotoSettingsCellAdded_labelTitle", comment:"")
        
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
            
            let added:TimeInterval = controller.photo?.created
            
        else
        {
            return
        }
        
        let date:Date = Date(timeIntervalSince1970:added)
        let addedString:String = dateFormatter.string(from:date)
        labelDate.text = addedString
    }
}
