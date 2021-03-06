import UIKit

class VSettingsCellAbout:VSettingsCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelVersion:UILabel = UILabel()
        labelVersion.isUserInteractionEnabled = false
        labelVersion.translatesAutoresizingMaskIntoConstraints = false
        labelVersion.backgroundColor = UIColor.clear
        labelVersion.font = UIFont.numeric(size:12)
        labelVersion.textColor = UIColor.black
        labelVersion.textAlignment = NSTextAlignment.center
        //labelVersion.text = buildVersion
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:16)
        labelTitle.textColor = UIColor.main
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.text = NSLocalizedString("VSettingsCellAbout_labelTitle", comment:"")
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericLogoNegative")
        
        addSubview(labelVersion)
        addSubview(labelTitle)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "labelVersion":labelVersion,
            "labelTitle":labelTitle,
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelVersion]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[imageView(70)]-(-10)-[labelTitle(25)]-(-7)-[labelVersion(20)]-40-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
