import UIKit

class VHomeUploadSyncBar:UIView
{
    private weak var controller:CHomeUploadSync!
    private weak var spinner:VSpinner!
    private weak var labelCount:UILabel!
    private weak var layoutCancelButtonLeft:NSLayoutConstraint!
    private let kSpinnerHeight:CGFloat = 80
    private let kCancelButtonWith:CGFloat = 90
    private let kCancelButtonHeight:CGFloat = 34
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
        
        let views:[String:UIView] = [
            "border":border,
            "cancelButton":cancelButton,
            "spinner":spinner,
            "labelCount":labelCount]
        
        let metrics:[String:CGFloat] = [
            "spinnerHeight":kSpinnerHeight,
            "cancelButtonWidth":kCancelButtonWith,
            "cancelButtonHeight":kCancelButtonHeight,
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
            withVisualFormat:"V:[cancelButton(cancelButtonHeight)]-10-[spinner(spinnerHeight)]-0-[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelCount(cancelButtonHeight)]-10-[spinner]",
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
        update()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let cancelButtonLabelWidth:CGFloat = kCancelButtonWith + kLabelCountWidth
        let remainCancelButton:CGFloat = width - cancelButtonLabelWidth
        let marginCancelButton:CGFloat = remainCancelButton / 2.0
        layoutCancelButtonLeft.constant = marginCancelButton
        
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
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
                
                let uploadItems:[MHomeUploadItem] = self?.controller.uploadItems
            
            else
            {
                return
            }
            
            let totalItems:Int = uploadItems.count
            var uploadedItems:Int = 0
            
            for item:MHomeUploadItem in uploadItems
            {
                if item.status == MHomeUploadItem.Status.Synced
                {
                    uploadedItems += 1
                }
            }
            
            let countText:String = "\(uploadedItems)/\(totalItems)"
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.labelCount.text = countText
            }
        }
    }
}
