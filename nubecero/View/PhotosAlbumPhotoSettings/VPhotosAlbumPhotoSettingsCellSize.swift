import UIKit

class VPhotosAlbumPhotoSettingsCellSize:VPhotosAlbumPhotoSettingsCell
{
    private weak var labelSize:UILabel!
    private let numberFormatter:NumberFormatter
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:14)
        labelTitle.textColor = UIColor.complement
        labelTitle.text = NSLocalizedString("VPhotosAlbumPhotoSettingsCellSize_labelTitle", comment:"")
        
        let labelSize:UILabel = UILabel()
        labelSize.translatesAutoresizingMaskIntoConstraints = false
        labelSize.isUserInteractionEnabled = false
        labelSize.backgroundColor = UIColor.clear
        labelSize.font = UIFont.regular(size:17)
        labelSize.textColor = UIColor.black
        self.labelSize = labelSize
        
        addSubview(labelTitle)
        addSubview(labelSize)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelSize":labelSize]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelTitle(50)]-0-[labelSize(250)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelSize]-0-|",
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
            
            let photo:MPhotosItemPhoto = controller.photo
            
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
