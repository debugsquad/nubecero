import UIKit

class VOnboardFormCellRemember:VOnboardFormCell
{
    private weak var check:UISwitch!
    
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
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.regular(size:14)
        label.textColor = UIColor.black
        label.text = NSLocalizedString("VOnboardFormCellRemember_label", comment:"")
        
        addSubview(label)
        addSubview(check)
        
        let views:[String:UIView] = [
            "label":label,
            "check":check]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[label(150)]-10-[check(72)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[check]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[label(31)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MOnboardFormItem, controller:COnboardForm)
    {
        guard
        
            let remember:Bool = MSession.sharedInstance.settings?.rememberMe
        
        else
        {
            return
        }
        
        check.isOn = remember
    }
    
    //MARK: actions
    
    func actionCheck(sender check:UISwitch)
    {
        let shouldRemember:Bool = check.isOn
        
        MSession.sharedInstance.settings?.rememberMe = shouldRemember
        DManager.sharedInstance.save()
    }
}
