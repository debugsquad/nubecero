import UIKit

class VHomeUploadSyncBar:UIView
{
    weak var controller:CHomeUploadSync!
    
    convenience init(controller:CHomeUploadSync)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:UIView = UIView()
        border.backgroundColor = UIColor.black
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        
        let cancelButton:UIButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitleColor(UIColor.black, for:UIControlState.normal)
        cancelButton.setTitleColor(UIColor.white, for:UIControlState.highlighted)
        cancelButton.setTitle(NSLocalizedString("VHomeUploadSyncBar_cancel", comment:""), for:UIControlState.normal)
        cancelButton.titleLabel!.font = UIFont.medium(size:14)
        
        addSubview(border)
        addSubview(cancelButton)
        
        let views:[String:UIView] = [
            "border":border,
            "cancelButton":cancelButton]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[cancelButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[cancelButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
