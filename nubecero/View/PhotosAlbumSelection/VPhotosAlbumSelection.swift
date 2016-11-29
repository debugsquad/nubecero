import UIKit

class VPhotosAlbumSelection:UIView
{
    private weak var controller:CPhotosAlbumSelection!
    private weak var collectionView:UICollectionView!
    private weak var layoutButtonCancelLeft:NSLayoutConstraint!
    private let kButtonCancelWidth:CGFloat = 120
    
    convenience init(controller:CPhotosAlbumSelection)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.isUserInteractionEnabled = false
        visualEffect.clipsToBounds = true
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0, alpha:0.3),
            for:UIControlState.highlighted)
        buttonCancel.setTitle(
            NSLocalizedString("VPhotosAlbumSelection_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.titleLabel!.font = UIFont.regular(size:16)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(visualEffect)
        addSubview(buttonCancel)

        let views:[String:UIView] = [
            "buttonCancel":buttonCancel]
        
        let metrics:[String:CGFloat] = [
            "buttonCancelWidth":kButtonCancelWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonCancel(buttonCancelWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonCancel(40)]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonCancelLeft = NSLayoutConstraint(
            item:buttonCancel,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonCancelLeft)
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonCancelWidth
        let margin:CGFloat = remain / 2.0
        
        layoutButtonCancelLeft.constant = margin
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
}
