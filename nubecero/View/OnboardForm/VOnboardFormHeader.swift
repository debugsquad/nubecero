import UIKit

class VOnboardFormHeader:UICollectionReusableView
{
    private weak var controller:COnboardForm?
    private weak var labelTitle:UILabel!
    private let kButtonCancelWidth:CGFloat = 95
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "assetGenericLogoNegative")
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.setTitleColor(UIColor.main, for:UIControlState.normal)
        buttonCancel.setTitleColor(UIColor.black, for:UIControlState.highlighted)
        buttonCancel.setTitle(
            NSLocalizedString("VOnboardFormHeader_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.titleLabel!.font = UIFont.medium(size:17)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.regular(size:22)
        labelTitle.textColor = UIColor.black
        self.labelTitle = labelTitle
        
        addSubview(imageView)
        addSubview(labelTitle)
        addSubview(buttonCancel)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "buttonCancel":buttonCancel,
            "labelTitle":labelTitle]
        
        let metrics:[String:CGFloat] = [
            "buttonCancelWidth":kButtonCancelWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[buttonCancel(buttonCancelWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelTitle(250)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[buttonCancel(44)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-22-[imageView(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelTitle(25)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller?.cancel()
    }
    
    //MARK: config
    
    func config(controller:COnboardForm)
    {
        self.controller = controller
        labelTitle.text = controller.model.title
    }
}
