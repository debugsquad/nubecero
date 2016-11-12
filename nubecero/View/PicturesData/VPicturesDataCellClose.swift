import UIKit

class VPicturesDataCellClose:VPicturesDataCell
{
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kCornerRadius:CGFloat = 4
    private let kButtonWidth:CGFloat = 125
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.complement
        button.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        button.setTitle(
            NSLocalizedString("VPicturesDataCellClose_buttonTitle", comment:""),
            for:UIControlState.normal)
        button.layer.cornerRadius = kCornerRadius
        button.titleLabel!.font = UIFont.medium(size:14)
        button.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        let views:[String:UIView] = [
            "button":button]
        
        let metrics:[String:CGFloat] = [
            "buttonWidth":kButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[button(buttonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(42)-[button]-(42)-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonLeft = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let maxWidth:CGFloat = bounds.maxX
        let remainX:CGFloat = maxWidth - kButtonWidth
        let margin:CGFloat = remainX / 2.0
        layoutButtonLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller?.parentController.dismiss()
    }
}
