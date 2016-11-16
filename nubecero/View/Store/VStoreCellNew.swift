import UIKit

class VStoreCellNew:VStoreCell
{
    private weak var labelPrice:UILabel!
    private let kButtonPurchaseWidth:CGFloat = 100
    private let kLabelPriceWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let buttonPurchase:UIButton = UIButton()
        buttonPurchase.translatesAutoresizingMaskIntoConstraints = false
        buttonPurchase.backgroundColor = UIColor.complement
        buttonPurchase.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonPurchase.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonPurchase.setTitle(
            NSLocalizedString("VStoreCellNew_buttonPurchase", comment:""),
            for:UIControlState.normal)
        buttonPurchase.titleLabel!.font = UIFont.medium(size:15)
        buttonPurchase.addTarget(
            self,
            action:#selector(actionPurchase(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let labelPrice:UILabel = UILabel()
        labelPrice.isUserInteractionEnabled = false
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.backgroundColor = UIColor.clear
        labelPrice.font = UIFont.medium(size:16)
        labelPrice.textColor = UIColor.black
        labelPrice.textAlignment = NSTextAlignment.right
        self.labelPrice = labelPrice
        
        addSubview(buttonPurchase)
        addSubview(labelPrice)
        
        let views:[String:UIView] = [
            "buttonPurchase":buttonPurchase,
            "labelPrice":labelPrice]
        
        let metrics:[String:CGFloat] = [
            "buttonPurchaseWidth":kButtonPurchaseWidth,
            "labelPriceWidth":kLabelPriceWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[labelPrice(labelPriceWidth)]-10-[buttonPurchase(buttonPurchaseWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonPurchase]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelPrice]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CStore, model:MStoreItem)
    {
        super.config(controller:controller, model:model)
        labelPrice.text = model.price
    }
    
    //MARK: actions
    
    func actionPurchase(sender button:UIButton)
    {
        controller?.purchase(skProduct:model?.skProduct)
    }
}
