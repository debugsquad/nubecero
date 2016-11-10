import UIKit

class VOnboardFormCellPassGenerator:VOnboardFormCell
{
    private weak var passwordField:UITextField?
    private let kCornerRadius:CGFloat = 4
    private let kButtonWidth:CGFloat = 160
    
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
            withVisualFormat:"V:|-3-[button]-0-|",
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
