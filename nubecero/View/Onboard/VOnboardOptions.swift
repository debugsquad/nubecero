import UIKit

class VOnboardOptions:UIView
{
    private weak var controller:COnboard!
    private weak var baseButtons:UIView!
    private weak var layoutBaseButtonsLeft:NSLayoutConstraint!
    private let kBaseButtonsWith:CGFloat = 280
    private let kButtonsHorizontalMargin:CGFloat = -10
    
    convenience init(controller:COnboard)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let baseButtonsWidth_2:CGFloat = kBaseButtonsWith / 2.0
        let buttonsWidth:CGFloat = baseButtonsWidth_2 - kButtonsHorizontalMargin
        let buttonRegisterTitle:String = NSLocalizedString("VOnboardOptions_buttonRegister", comment:"")
        let buttonSigninTitle:String = NSLocalizedString("VOnboardOptions_buttonSignin", comment:"")
        
        let buttonRegister:VOnboardOptionsButton = VOnboardOptionsButton(
            title:buttonRegisterTitle)
        let buttonSignin:VOnboardOptionsButton = VOnboardOptionsButton(
            title:buttonSigninTitle)
        
        let baseButtons:UIView = UIView()
        baseButtons.translatesAutoresizingMaskIntoConstraints = false
        baseButtons.clipsToBounds = true
        self.baseButtons = baseButtons
        
        baseButtons.addSubview(buttonRegister)
        baseButtons.addSubview(buttonSignin)
        addSubview(baseButtons)
        
        let views:[String:UIView] = [
            "buttonRegister":buttonRegister,
            "buttonSignin":buttonSignin,
            "baseButtons":baseButtons]
        
        let metrics:[String:CGFloat] = [
            "baseButtonsWidth":kBaseButtonsWith,
            "buttonsHorizontalMargin":kButtonsHorizontalMargin,
            "buttonsWidth":buttonsWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[baseButtons(baseButtonsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(buttonsHorizontalMargin)-[buttonRegister(buttonsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonSignin(buttonsWidth)]-(buttonsHorizontalMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[baseButtons]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonRegister]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonSignin]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBaseButtonsLeft = NSLayoutConstraint(
            item:baseButtons,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBaseButtonsLeft)
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let height_2:CGFloat = height / 2.0
        let remain:CGFloat = width - kBaseButtonsWith
        let margin:CGFloat = remain / 2.0
        layoutBaseButtonsLeft.constant = margin
        baseButtons.layer.cornerRadius = height_2
        
        super.layoutSubviews()
    }
}
