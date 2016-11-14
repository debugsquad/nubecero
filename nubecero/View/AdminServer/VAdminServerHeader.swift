import UIKit

class VAdminServerHeader:UICollectionReusableView
{
    private weak var controller:CAdminServer?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.main, for:UIControlState.normal)
        button.setTitleColor(UIColor.complement, for:UIControlState.highlighted)
        button.setTitle(NSLocalizedString("VAdminServerHeader_button", comment:""), for:UIControlState.normal)
        button.titleLabel!.font = UIFont.bold(size:16)
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        let views:[String:UIView] = [
            "button":button]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[button(95)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller?.confirmSave()
    }
    
    //MARK: public
    
    func config(controller:CAdminServer)
    {
        self.controller = controller
    }
}
