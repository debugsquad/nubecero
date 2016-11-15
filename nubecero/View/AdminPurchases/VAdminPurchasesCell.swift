import UIKit

class VAdminPurchasesCell:UICollectionViewCell
{
    private weak var controller:CAdminPurchases?
    private weak var model:MAdminPurchasesItem?
    private weak var labelId:UILabel!
    private weak var fieldName:UITextField!
    private weak var fieldPurchaseId:UITextField!
    private weak var buttonDelete:UIButton!
    private weak var check:UISwitch!
    private let kAlphaDeletable:CGFloat = 1
    private let kAlphaNotDeletable:CGFloat = 0.3
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let buttonDelete:UIButton = UIButton()
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        buttonDelete.setTitleColor(
            UIColor.main,
            for:UIControlState.normal)
        buttonDelete.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonDelete.setTitle(
            NSLocalizedString("VAdminPurchasesCell_buttonDelete", comment:""),
            for:UIControlState.normal)
        buttonDelete.titleLabel!.font = UIFont.bold(size:14)
        buttonDelete.addTarget(
            self,
            action:#selector(actionDelete(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonDelete = buttonDelete
        
        let labelId:UILabel = UILabel()
        labelId.isUserInteractionEnabled = false
        labelId.translatesAutoresizingMaskIntoConstraints = false
        labelId.backgroundColor = UIColor.clear
        labelId.font = UIFont.regular(size:14)
        labelId.textColor = UIColor(white:0.3, alpha:1)
        self.labelId = labelId
        
        let check:UISwitch = UISwitch()
        check.translatesAutoresizingMaskIntoConstraints = false
        check.onTintColor = UIColor.main
        check.addTarget(
            self,
            action:#selector(actionCheck(sender:)),
            for:UIControlEvents.valueChanged)
        self.check = check
        
        addSubview(labelId)
        addSubview(buttonDelete)
        addSubview(check)
        
        let views:[String:UIView] = [
            "labelId":labelId,
            "buttonDelete":buttonDelete,
            "check":check]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelId(220)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonDelete(100)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[check]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-5-[buttonDelete(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-15-[labelId(20)]-5-[check]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionDelete(sender button:UIButton)
    {
        guard
            
            let model:MAdminPurchasesItem = model
        
        else
        {
            return
        }
        
        controller?.deletePurchase(item:model)
    }
    
    func actionCheck(sender check:UISwitch)
    {
        if check.isOn
        {
            model?.status = FDatabaseModelPurchase.Status.active
        }
        else
        {
            model?.status = FDatabaseModelPurchase.Status.hidden
        }
    }
    
    //MARK: private
    
    private func allowDeletion()
    {
        buttonDelete.isUserInteractionEnabled = true
        buttonDelete.alpha = kAlphaDeletable
    }
    
    private func preventDeletion()
    {
        buttonDelete.isUserInteractionEnabled = false
        buttonDelete.alpha = kAlphaNotDeletable
    }
    
    //MARK: public
    
    func config(controller:CAdminPurchases, model:MAdminPurchasesItem)
    {
        self.controller = controller
        self.model = model
        labelId.text = model.firebasePurchaseId
        
        if model.originalStatus == FDatabaseModelPurchase.Status.active
        {
            preventDeletion()
        }
        else
        {
            allowDeletion()
        }
        
        if model.status == FDatabaseModelPurchase.Status.active
        {
            check.isOn = true
        }
        else
        {
            check.isOn = false
        }
    }
}
