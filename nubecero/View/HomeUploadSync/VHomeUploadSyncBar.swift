import UIKit

class VHomeUploadSyncBar:UIView
{
    private weak var controller:CHomeUploadSync!
    private weak var spinner:VSpinner!
    private weak var layoutCancelButtonLeft:NSLayoutConstraint!
    private let kSpinnerHeight:CGFloat = 60
    private let kCancelButtonWith:CGFloat = 120
    private let kCancelButtonHeight:CGFloat = 34
    private let kCornerRadius:CGFloat = 4
    
    convenience init(controller:CHomeUploadSync)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let border:UIView = UIView()
        border.backgroundColor = UIColor.black
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        
        let cancelButton:UIButton = UIButton()
        cancelButton.backgroundColor = UIColor.main
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitleColor(UIColor.white, for:UIControlState.normal)
        cancelButton.setTitleColor(UIColor.black, for:UIControlState.highlighted)
        cancelButton.setTitle(
            NSLocalizedString("VHomeUploadSyncBar_cancel", comment:""),
            for:UIControlState.normal)
        cancelButton.titleLabel!.font = UIFont.medium(size:13)
        cancelButton.layer.cornerRadius = kCornerRadius
        cancelButton.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(cancelButton)
        addSubview(spinner)
        
        let views:[String:UIView] = [
            "border":border,
            "cancelButton":cancelButton]
        
        let metrics:[String:CGFloat] = [
            "spinnerHeight":kSpinnerHeight,
            "cancelButtonWith":kCancelButtonWith,
            "cancelButtonHeight":kCancelButtonHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[cancelButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[cancelButton(cancelButtonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[cancelButton(cancelButtonHeight)]-0-[spinner(spinnerHeight)]-0-[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutCancelButtonLeft = NSLayoutConstraint(
            item:cancelButton,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutCancelButtonLeft)
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainCancelButton:CGFloat = width - kCancelButtonWith
        let marginCancelButton:CGFloat = remainCancelButton / 2.0
        layoutCancelButtonLeft.constant = marginCancelButton
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancelSync()
    }
}
