import UIKit

class VOnboardFormCellPassGenerator:VOnboardFormCell
{
    private weak var passwordField:UITextField?
    private weak var modelPassGenerator:MOnboardFormItemPassGenerator?
    private let kCornerRadius:CGFloat = 4
    private let kButtonWidth:CGFloat = 165
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.main
        button.setTitleColor(UIColor.white, for:UIControlState.normal)
        button.setTitleColor(UIColor(white:1, alpha:0.2), for:UIControlState.highlighted)
        button.setTitle(NSLocalizedString("VOnboardFormCellPassGenerator_buttonTitle", comment:""), for:UIControlState.normal)
        button.titleLabel!.font = UIFont.medium(size:13)
        button.layer.cornerRadius = kCornerRadius
        button.addTarget(
            self,
            action:#selector(actionGeneratePassword(sender:)),
            for:UIControlEvents.touchUpInside)

        addSubview(button)
        
        let views:[String:UIView] = [
            "button":button]
        
        let metrics:[String:CGFloat] = [
            "buttonWidth":kButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-20-[button(buttonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-6-[button]-5-|",
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
        super.config(model:model, controller:controller)
        passwordField = controller.passwordField
        modelPassGenerator = model as? MOnboardFormItemPassGenerator
    }
    
    //MARK: actions
    
    func actionGeneratePassword(sender button:UIButton)
    {
        passwordField?.text = modelPassGenerator?.generatePassword()
        passwordField?.isSecureTextEntry = false
    }
}
