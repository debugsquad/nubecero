import UIKit

class VAdminPurchasesCell:UICollectionViewCell
{
    private weak var controller:CAdminPurchases?
    private weak var model:MAdminPurchasesItem?
    private weak var labelId:UILabel!
    private weak var fieldName:UITextField!
    private weak var fieldPurchaseId:UITextField!
    
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
        
        let labelId:UILabel = UILabel()
        labelId.isUserInteractionEnabled = false
        labelId.translatesAutoresizingMaskIntoConstraints = false
        labelId.backgroundColor = UIColor.clear
        labelId.font = UIFont.regular(size:14)
        labelId.textColor = UIColor(white:0.6, alpha:1)
        self.labelId = labelId
        
        addSubview(labelId)
        addSubview(buttonDelete)
        
        let views:[String:UIView] = [
            "labelId":labelId,
            "buttonDelete":buttonDelete]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelId(180)]-0-[buttonDelete(120)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonDelete(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[labelId(20)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CAdminPurchases, model:MAdminPurchasesItem)
    {
        self.controller = controller
        self.model = model
        labelId.text = model.firebasePurchaseId
    }
}
