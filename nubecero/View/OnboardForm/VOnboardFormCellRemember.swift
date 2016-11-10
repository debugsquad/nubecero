import UIKit

class VOnboardFormCellRemember:VOnboardCell
{
    private weak var check:UISwitch!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let check:UISwitch = UISwitch()
        check.translatesAutoresizingMaskIntoConstraints = false
        check.onTintColor = UIColor.main
        self.check = check
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.regular(size:14)
        label.text = NSLocalizedString("VOnboardFormCellRemember_label", comment:"")
        
        addSubview(label)
        addSubview(check)
        
        let views:[String:UIView] = [
            "label":label,
            "check":check]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[label(150)]-10-[check(90)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[check]",
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
}
