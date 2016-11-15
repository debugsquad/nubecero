import UIKit

class VAdminPurchasesHeader:UICollectionReusableView
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonSave:UIButton = UIButton()
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        buttonSave.setTitleColor(
            UIColor.main,
            for:UIControlState.normal)
        buttonSave.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonSave.setTitle(
            NSLocalizedString("VAdminPurchasesHeader_buttonSave", comment:""),
            for:UIControlState.normal)
        buttonSave.titleLabel!.font = UIFont.medium(size:15)
        
        let buttonAdd:UIButton = UIButton()
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.setTitleColor(
            UIColor.complement,
            for:UIControlState.normal)
        buttonAdd.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonAdd.setTitle(
            NSLocalizedString("VAdminPurchasesHeader_buttonAdd", comment:""),
            for:UIControlState.normal)
        buttonAdd.titleLabel!.font = UIFont.medium(size:15)
        
        addSubview(buttonSave)
        addSubview(buttonAdd)
        
        let views:[String:UIView] = [
            "buttonSave":buttonSave,
            "buttonAdd":buttonAdd]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[buttonSave(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonAdd(140)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-15-[buttonSave]-15-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-15-[buttonAdd]-15-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
