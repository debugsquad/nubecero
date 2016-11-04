import UIKit

class VAuth:UIView
{
    private weak var controller:CAuth!
    private weak var buttonTryAgain:UIButton!
    private let kButtonTryAgainWidth:CGFloat = 100
    private let kButtonTryAgainHeight:CGFloat = 34
    private let kButtonTryAgainBottom:CGFloat = 40
    private let kCornerRadius:CGFloat = 4
    
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
        imageView.image = #imageLiteral(resourceName: "assetGenericLogo")
        
        let buttonTryAgain:UIButton = UIButton()
        buttonTryAgain.isHidden = true
        buttonTryAgain.clipsToBounds = true
        buttonTryAgain.translatesAutoresizingMaskIntoConstraints = false
        buttonTryAgain.backgroundColor = UIColor.complement
        buttonTryAgain.setTitleColor(UIColor.white, for:UIControlState.normal)
        buttonTryAgain.setTitleColor(UIColor.black, for:UIControlState.highlighted)
        buttonTryAgain.setTitle(
            NSLocalizedString("VAuth_buttonTryAgain", comment:""),
            for:UIControlState.normal)
        buttonTryAgain.titleLabel!.font = UIFont.medium(size:14)
        buttonTryAgain.layer.cornerRadius = kCornerRadius
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
    }
    
    //MARK: public
    
    func showTryAgain()
    {
        
    }
}
