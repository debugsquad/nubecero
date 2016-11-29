import UIKit

class VPhotosAlbumPhotoSettingsCellPixels:VPhotosAlbumPhotoSettingsCell
{
    private weak var labelWidth:UILabel!
    private weak var labelHeight:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        
        let labelWidth:UILabel = UILabel()
        labelWidth.translatesAutoresizingMaskIntoConstraints = false
        labelWidth.isUserInteractionEnabled = false
        labelWidth.backgroundColor = UIColor.clear
        labelWidth.font = UIFont.regular(size:14)
        labelWidth.textColor = UIColor.black
        labelWidth.textAlignment = NSTextAlignment.center
        self.labelWidth = labelWidth
        
        let labelHeight:UILabel = UILabel()
        labelHeight.translatesAutoresizingMaskIntoConstraints = false
        labelHeight.isUserInteractionEnabled = false
        labelHeight.backgroundColor = UIColor.clear
        labelHeight.font = UIFont.regular(size:14)
        labelHeight.textColor = UIColor.black
        self.labelHeight = labelHeight
        
        addSubview(labelWidth)
        addSubview(labelHeight)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "labelWidth":labelWidth,
            "labelHeight":labelHeight]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView(100)]-10-[labelHeight(210)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelWidth(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelHeight(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView(100)]-10-[labelWidth(18)]",
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
        
        let width:Int = photo.width
        let height:Int = photo.height
        let widthNumber:NSNumber = width as NSNumber
        let heightNumber:NSNumber = height as NSNumber
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
