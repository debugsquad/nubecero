import UIKit

class VHomeUploadSyncBar:UIView
{
    private weak var controller:CHomeUploadSync!
    private weak var spinner:VSpinner!
    private weak var labelCount:UILabel!
    private weak var tryAgainButton:UIButton!
    private weak var layoutCancelButtonLeft:NSLayoutConstraint!
    private weak var layoutTryAgainButtonLeft:NSLayoutConstraint!
    private let kSpinnerHeight:CGFloat = 80
    private let kCancelButtonWith:CGFloat = 90
    private let kTryAgainButtonWith:CGFloat = 90
    private let kButtonHeight:CGFloat = 34
    private let kLabelCountWidth:CGFloat = 60
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
        cancelButton.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        cancelButton.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        cancelButton.setTitle(
            NSLocalizedString("VHomeUploadSyncBar_cancel", comment:""),
            for:UIControlState.normal)
        cancelButton.titleLabel!.font = UIFont.medium(size:13)
        cancelButton.layer.cornerRadius = kCornerRadius
        cancelButton.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let tryAgainButton:UIButton = UIButton()
        tryAgainButton.backgroundColor = UIColor.complement
        tryAgainButton.clipsToBounds = true
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        tryAgainButton.setTitleColor(UIColor.white, for:UIControlState.normal)
        tryAgainButton.setTitleColor(UIColor.black, for:UIControlState.highlighted)
        tryAgainButton.setTitle(
            NSLocalizedString("VHomeUploadSyncBar_tryAgain", comment:""),
            for:UIControlState.highlighted)
        tryAgainButton.layer.cornerRadius = kCornerRadius
        tryAgainButton.titleLabel!.font = UIFont.medium(size:13)
        tryAgainButton.isHidden = true
        self.tryAgainButton = tryAgainButton
        
        let labelCount:UILabel = UILabel()
        labelCount.isUserInteractionEnabled = false
        labelCount.translatesAutoresizingMaskIntoConstraints = false
        labelCount.backgroundColor = UIColor.clear
        labelCount.font = UIFont.medium(size:13)
        labelCount.textColor = UIColor.black
        labelCount.textAlignment = NSTextAlignment.right
        self.labelCount = labelCount
        
        addSubview(border)
        addSubview(cancelButton)
        addSubview(spinner)
        addSubview(labelCount)
        addSubview(tryAgainButton)
        
        let views:[String:UIView] = [
            "border":border,
            "cancelButton":cancelButton,
            "spinner":spinner,
            "labelCount":labelCount,
            "tryAgainButton":tryAgainButton]
        
        let metrics:[String:CGFloat] = [
            "spinnerHeight":kSpinnerHeight,
            "cancelButtonWidth":kCancelButtonWith,
            "tryAgainButtonWidth":kTryAgainButtonWith,
            "buttonHeight":kButtonHeight,
            "labelCountWidth":kLabelCountWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[cancelButton(cancelButtonWidth)]-0-[labelCount(labelCountWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[cancelButton(buttonHeight)]-10-[spinner(spinnerHeight)]-0-[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelCount(cancelButtonHeight)]-10-[spinner]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[tryAgainButton(buttonHeight)]-10-[border(1)]-0-|",
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
        
        layoutTryAgainButtonLeft = NSLayoutConstraint(
            item:tryAgainButton,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutCancelButtonLeft)
        addConstraint(layoutTryAgainButtonLeft)
        update()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let cancelButtonLabelWidth:CGFloat = kCancelButtonWith + kLabelCountWidth
        let remainCancelButton:CGFloat = width - cancelButtonLabelWidth
        let marginCancelButton:CGFloat = remainCancelButton / 2.0
        let remainTryAgainButton:CGFloat = width - kTryAgainButtonWith
        let marginTryAgainButton:CGFloat = remainTryAgainButton / 2.0
        
        layoutCancelButtonLeft.constant = marginCancelButton
        layoutTryAgainButtonLeft.constant = marginTryAgainButton
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancelSync()
    }
    
    //MARK: public
    
    func update()
    {
        let totalItems:Int = controller.uploadItems.count
        let uploadedItems:Int = controller.currentItem
        let countText:String = "\(uploadedItems)/\(totalItems)"
        
        labelCount.text = countText
    }
}
