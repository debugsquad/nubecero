import UIKit

class VSettingsCellAccount:VSettingsCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelEmail:UILabel = UILabel()
        labelEmail.isUserInteractionEnabled = false
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.backgroundColor = UIColor.clear
        labelEmail.font = UIFont.medium(size:14)
        labelEmail.textColor = UIColor(white:0.3, alpha:1)
        labelEmail.text = ""
        
        addSubview(labelEmail)
        
        let views:[String:UIView] = [
            "labelEmail":labelEmail]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-18-[labelEmail]-18-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelEmail]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
