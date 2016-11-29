import UIKit

class VPhotosAlbumPhotoSettingsCellAlbum:VPhotosAlbumPhotoSettingsCell
{
    private weak var labelAlbum:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.white
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:14)
        labelTitle.textColor = UIColor.complement
        labelTitle.text = NSLocalizedString("VPhotosAlbumPhotoSettingsCellAlbum_labelTitle", comment:"")
        
        let labelAlbum:UILabel = UILabel()
        labelAlbum.translatesAutoresizingMaskIntoConstraints = false
        labelAlbum.isUserInteractionEnabled = false
        labelAlbum.backgroundColor = UIColor.clear
        labelAlbum.font = UIFont.regular(size:17)
        labelAlbum.textColor = UIColor.black
        self.labelAlbum = labelAlbum
        
        let buttonChange:UIButton = UIButton()
        buttonChange.translatesAutoresizingMaskIntoConstraints = false
        buttonChange.backgroundColor = UIColor.main
        buttonChange.setTitle(
            NSLocalizedString("VPhotosAlbumPhotoSettingsCellAlbum_buttonChange", comment:""),
            for:UIControlState.normal)
        buttonChange.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonChange.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonChange.titleLabel!.font = UIFont.medium(size:14)
        buttonChange.clipsToBounds = true
        buttonChange.layer.cornerRadius = 4
        
        addSubview(labelTitle)
        addSubview(labelAlbum)
        addSubview(buttonChange)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelAlbum":labelAlbum]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelTitle(65)]-0-[labelAlbum(160)]-5-[buttonChange(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-14-[buttonChange]-14-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelAlbum]-0-|",
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
        
        labelAlbum.text = controller.photoController.albumController.model.name
    }
}
