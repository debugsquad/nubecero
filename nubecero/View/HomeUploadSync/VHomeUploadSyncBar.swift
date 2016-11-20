import UIKit

class VHomeUploadSyncBar:UIView
{
    private weak var controller:CHomeUploadSync!
    private weak var spinner:VSpinner!
    private weak var labelCount:UILabel!
    private weak var tryAgainButton:UIButton!
    private let attributesUploaded:[String:Any]
    private let attributesTotal:[String:Any]
    private let kSpinnerHeight:CGFloat = 80
    private let kCancelButtonWith:CGFloat = 80
    private let kTryAgainButtonWith:CGFloat = 150
    private let kCornerRadius:CGFloat = 4
    
    init(controller:CHomeUploadSync)
    {
        attributesUploaded = [
            NSFontAttributeName:UIFont.medium(size:26),
            NSForegroundColorAttributeName:UIColor.black
        ]
        
        attributesTotal = [
            NSFontAttributeName:UIFont.medium(size:15),
            NSForegroundColorAttributeName:UIColor.black
        ]
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.7)
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
            for:UIControlState.normal)
        tryAgainButton.layer.cornerRadius = kCornerRadius
        tryAgainButton.titleLabel!.font = UIFont.medium(size:13)
        tryAgainButton.isHidden = true
        tryAgainButton.addTarget(
            self,
            action:#selector(actionTryAgain(sender:)),
            for:UIControlEvents.touchUpInside)
        self.tryAgainButton = tryAgainButton
        
        let labelCount:UILabel = UILabel()
        labelCount.isUserInteractionEnabled = false
        labelCount.translatesAutoresizingMaskIntoConstraints = false
        labelCount.backgroundColor = UIColor.clear
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
            "tryAgainButtonWidth":kTryAgainButtonWith]
        
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
            withVisualFormat:"H:|-10-[cancelButton(cancelButtonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[labelCount(150)]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[tryAgainButton(tryAgainButtonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[spinner(spinnerHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-34-[cancelButton(32)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-30-[labelCount(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-34-[tryAgainButton(32)]",
            options:[],
            metrics:metrics,
            views:views))
        
        update()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancelSync()
    }
    
    func actionTryAgain(sender button:UIButton)
    {
        spinner.startAnimating()
        tryAgainButton.isHidden = true
        controller.keepSyncing()
    }

    //MARK: public
    
    func update()
    {
        let uploadedItems:Int = controller.uploadedItems()
        let totalItems:Int = controller.uploadItems.count
        let totalItemsString:String = "\(totalItems)"
        let uploadedItemString:String = "\(uploadedItems)"
        let totalItemsStringComposite:String = String(
            format:NSLocalizedString("VHomeUploadSyncBar_totalItems", comment:""),
            totalItemsString)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let attUploaded:NSAttributedString = NSAttributedString(
            string:uploadedItemString,
            attributes:attributesUploaded)
        let attTotal:NSAttributedString = NSAttributedString(
            string:totalItemsStringComposite,
            attributes:attributesTotal)
        
        mutableString.append(attUploaded)
        mutableString.append(attTotal)
        
        labelCount.attributedText = mutableString
    }
    
    func errorFound()
    {
        spinner.stopAnimating()
        tryAgainButton.isHidden = false
    }
}
