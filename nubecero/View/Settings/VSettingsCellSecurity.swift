import UIKit

class VSettingsCellSecurity:VSettingsCell
{
    private weak var check:UISwitch!
    private let kCheckWidth:CGFloat = 72
    private let kCheckTop:CGFloat = 23
    
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
        label.textColor = UIColor(white:0.25, alpha:1)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.right
        label.text = NSLocalizedString("VSettingsCellSecurity_label", comment:"")
        
        addSubview(label)
        addSubview(check)
        
        let views:[String:UIView] = [
            "check":check,
            "label":label]
        
        let metrics:[String:CGFloat] = [
            "checkWidth":kCheckWidth,
            "checkTop":kCheckTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-10-[check(checkWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(checkTop)-[check]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[label]-0-|",
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
        
            let securityOn:Bool = MSession.sharedInstance.settings?.security
        
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
        MSession.sharedInstance.settings?.security = securityOn
        
        DManager.sharedInstance.save()
    }
}
