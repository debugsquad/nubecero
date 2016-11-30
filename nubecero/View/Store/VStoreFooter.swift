import UIKit

class VStoreFooter:UICollectionReusableView
{
    private weak var controller:CStore?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(
            UIColor(white:0.4, alpha:1),
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:0.9, alpha:1),
            for:UIControlState.highlighted)
        button.setTitle(
            NSLocalizedString("VStoreFooter_buttonRestore", comment:""),
            for:UIControlState.normal)
        button.titleLabel!.font = UIFont.medium(size:15)
        button.addTarget(
            self,
            action:#selector(actionRestore(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        let views:[String:UIView] = [
            "button":button]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[button(35)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionRestore(sender button:UIButton)
    {
        FMain.sharedInstance.analytics?.purchaseRestore()
        controller?.restorePurchases()
    }
    
    //MARK: public
    
    func config(controller:CStore)
    {
        self.controller = controller
    }
}
