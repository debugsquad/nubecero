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
            withVisualFormat:"H:|-10-[labelTitle(60)]-0-[labelDate(250)]",
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
            
            let photo:MPhotosItemPhoto = controller.photo.add
            
        else
        {
            return
        }
        
        let size:Int = photo.size
        let sizeNumber:NSNumber = size as NSNumber
        
        guard
            
            let kilosString:String = numberFormatter.string(from:sizeNumber)
            
            else
        {
            return
        }
        
        let sizeString:String = String(
            format:NSLocalizedString("VPhotosAlbumPhotoSettingsCellSize_labelSize", comment:""),
            kilosString)
        
        labelSize.text = sizeString
    }
}
