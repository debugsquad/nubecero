import UIKit

class VSettingsCellAbout:VSettingsCell
{
    private let kBuildKey:String = "CFBundleVersion"
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let buildVersion:String? = Bundle.main.infoDictionary?[kBuildKey] as? String
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.numeric(size:22)
        label.textColor = UIColor(white:0.75, alpha:1)
        label.textAlignment = NSTextAlignment.center
        label.text = buildVersion
        
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[label(28)]-30-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
