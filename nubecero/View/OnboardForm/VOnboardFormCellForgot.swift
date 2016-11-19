import UIKit

class VOnboardFormCellForgot:VOnboardFormCell
{
    private weak var controller:COnboardForm?
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kButtonWidth:CGFloat = 160
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitleColor(UIColor.black, for:UIControlState.normal)
        button.setTitleColor(UIColor.complement, for:UIControlState.highlighted)
        button.setTitle(NSLocalizedString("VOnboardFormCellForgot_buttonTitle", comment:""), for:UIControlState.normal)
        button.titleLabel!.font = UIFont.medium(size:13)
        button.addTarget(
            self,
            action:#selector(actionForgot(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        let views:[String:UIView] = [
            "button":button]
        
        let metrics:[String:CGFloat] = [
            "buttonWidth":kButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[button(buttonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[button]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonLeft = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let margin:CGFloat = remain / 2.0
        
        layoutButtonLeft.constant = margin
        super.layoutSubviews()
    }
    
    override func config(model:MOnboardFormItem, controller:COnboardForm)
    {
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionForgot(sender button:UIButton)
    {
        FMain.sharedInstance.analytics?.sessionPasswordReset()
        controller?.forgotPassword()
    }
}
