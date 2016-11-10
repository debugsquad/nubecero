import UIKit

class VOnboardFormCellPassGenerator:VOnboardFormCell
{
    private weak var passwordField:UITextField?
    private let kCornerRadius:CGFloat = 4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.main
        button.setTitleColor(UIColor.white, for:UIControlState.normal)
        button.setTitleColor(UIColor(white:1, alpha:0.2), for:UIControlState.highlighted)
        button.setTitle(NSLocalizedString("VOnboardFormCellPassGenerator", comment:""), for:UIControlState.normal)
        button.titleLabel!.font = UIFont.medium(size:13)
        button.layer.cornerRadius = kCornerRadius
        
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
            withVisualFormat:"H:[label(150)]-10-[check(71)]-0-|",
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
    }
    
    //MARK: actions

}
