import UIKit

class VAuth:UIView
{
    private weak var controller:CAuth!
    private weak var buttonTryAgain:UIButton!
    private weak var layoutButtonTryAgainLeft:NSLayoutConstraint!
    private let kButtonTryAgainWidth:CGFloat = 180
    private let kButtonTryAgainHeight:CGFloat = 50
    private let kButtonTryAgainBottom:CGFloat = 20
    
    convenience init(controller:CAuth)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.main
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericLock")
        
        let buttonTryAgain:UIButton = UIButton()
        buttonTryAgain.isHidden = true
        buttonTryAgain.clipsToBounds = true
        buttonTryAgain.translatesAutoresizingMaskIntoConstraints = false
        buttonTryAgain.backgroundColor = UIColor.clear
        buttonTryAgain.setTitleColor(UIColor.white, for:UIControlState.normal)
        buttonTryAgain.setTitleColor(UIColor.complement, for:UIControlState.highlighted)
        buttonTryAgain.setTitle(
            NSLocalizedString("VAuth_buttonTryAgain", comment:""),
            for:UIControlState.normal)
        buttonTryAgain.titleLabel!.font = UIFont.bold(size:20)
        buttonTryAgain.addTarget(
            self,
            action:#selector(actionTryAgain(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonTryAgain = buttonTryAgain
        
        addSubview(imageView)
        addSubview(buttonTryAgain)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "buttonTryAgain":buttonTryAgain]
        
        let metrics:[String:CGFloat] = [
            "buttonTryAgainBottom":kButtonTryAgainBottom,
            "buttonTryAgainWidth":kButtonTryAgainWidth,
            "buttonTryAgainHeight":kButtonTryAgainHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonTryAgain(buttonTryAgainWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonTryAgain(buttonTryAgainHeight)]-(buttonTryAgainBottom)-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonTryAgainLeft = NSLayoutConstraint(
            item:buttonTryAgain,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonTryAgainLeft)
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainWidth:CGFloat = width - kButtonTryAgainWidth
        let margin:CGFloat = remainWidth / 2.0
        layoutButtonTryAgainLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionTryAgain(sender button:UIButton)
    {
        buttonTryAgain.isHidden = true
        controller.askAuth()
    }
    
    //MARK: public
    
    func showTryAgain()
    {
        buttonTryAgain.isHidden = false
    }
}
