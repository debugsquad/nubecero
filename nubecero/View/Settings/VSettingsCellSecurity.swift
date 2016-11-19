import UIKit

class VSettingsCellSecurity:VSettingsCell
{
    private weak var check:UISwitch!
    private let kCheckWidth:CGFloat = 65
    private let kCheckTop:CGFloat = 20
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let check:UISwitch = UISwitch()
        check.translatesAutoresizingMaskIntoConstraints = false
        check.onTintColor = UIColor.main
        check.addTarget(
            self,
            action:#selector(actionCheck(sender:)),
            for:UIControlEvents.valueChanged)
        self.check = check
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:15)
        label.textColor = UIColor.black
        label.text = NSLocalizedString("VSettingsCellSecurity_label", comment:"")
        
        let labelDescription:UILabel = UILabel()
        labelDescription.isUserInteractionEnabled = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.backgroundColor = UIColor.clear
        labelDescription.font = UIFont.regular(size:14)
        labelDescription.textColor = UIColor(white:0.45, alpha:1)
        labelDescription.numberOfLines =  0
        labelDescription.text = NSLocalizedString("VSettingsCellSecurity_labelDescription", comment:"")
        
        addSubview(labelDescription)
        addSubview(label)
        addSubview(check)
        
        let views:[String:UIView] = [
            "labelDescription":labelDescription,
            "check":check,
            "label":label]
        
        let metrics:[String:CGFloat] = [
            "checkWidth":kCheckWidth,
            "checkTop":kCheckTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-15-[check(checkWidth)]-0-[label(170)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-18-[labelDescription(290)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(checkTop)-[check]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(checkTop)-[label(32)]-5-[labelDescription(50)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MSettingsItem)
    {
        guard
        
            let securityOn:Bool = MSession.sharedInstance.settings.current?.security
        
        else
        {
            return
        }
        
        check.isOn = securityOn
    }
    
    //MARK: actions
    
    func actionCheck(sender check:UISwitch)
    {
        let securityOn:Bool = check.isOn
        MSession.sharedInstance.settings.current?.security = securityOn
        
        DManager.sharedInstance.save()
    }
}
