import UIKit

class VOnboardFormSender:UIView
{
    private weak var controller:COnboardForm!
    private let kCornerRadius:CGFloat = 4
    private let kButtonWidth:CGFloat = 100
    private let kButtonRight:CGFloat = 20
    
    convenience init(controller:COnboardForm)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        self.controller = controller
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:0, alpha:0.1)
        
        let button:UIButton = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = UIColor.complement
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = kCornerRadius
        button.setTitleColor(UIColor.white, for:UIControlState.normal)
        button.setTitleColor(UIColor(white:1, alpha:0.2), for:UIControlState.highlighted)
        button.setTitle(controller.model.buttonMessage, for:UIControlState.normal)
        button.titleLabel!.font = UIFont.medium(size:14)
        button.layer.cornerRadius = kCornerRadius
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(button)
        
        let views:[String:UIView] = [
            "border":border,
            "button":button]
        
        let metrics:[String:CGFloat] = [
            "buttonWidth":kButtonWidth,
            "buttonRight":kButtonRight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[border(1)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[button(buttonWidth)]-(buttonRight)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-5-[button]-5-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller.send()
    }
}
