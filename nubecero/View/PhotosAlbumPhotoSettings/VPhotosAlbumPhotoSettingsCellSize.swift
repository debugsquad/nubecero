import UIKit

class VPhotosAlbumPhotoSettingsCellSize:VPhotosAlbumPhotoSettingsCell
{
    private weak var labelSize:UILabel!
    private let numberFormatter:NumberFormatter
    private let kKiloBytesPerMega:CGFloat = 1000
    private let kMaxFractions:Int = 4
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxFractions
        
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
        labelSize.font = UIFont.regular(size:14)
        labelSize.textColor = UIColor.black
        self.labelSize = labelSize
        
        addSubview(labelTitle)
        addSubview(labelSize)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelSize":labelSize]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelTitle(65)]-0-[labelSize(250)]",
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
        
        let size:CGFloat = CGFloat(photo.size)
        let megas:CGFloat = size / kKiloBytesPerMega
        let megasNumber:NSNumber = megas as NSNumber
        
        let widthString:String = String(
            format:NSLocalizedString("VPhotosAlbumPhotoSettingsCellPixels_labelWidth", comment:""),
            widthNumber)
        let heightString:String = String(
            format:NSLocalizedString("VPhotosAlbumPhotoSettingsCellPixels_labelHeight", comment:""),
            heightNumber)
        
        labelWidth.text = widthString
        labelHeight.text = heightString
    }
}
