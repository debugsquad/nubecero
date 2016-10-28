import UIKit

class VAlert:UIView
{
    static let kMarginTop:CGFloat = 10
    static let kMarginHorizontal:CGFloat = 10
    static let kHeight:CGFloat = 60
    weak var layoutTop:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.4
    private let kTimeOut:TimeInterval = 3
    private let kFontSize:CGFloat = 15
    private let kLabelMargin:CGFloat = 10
    private let kCornerRadius:CGFloat = 5
    private let kBorderWidth:CGFloat = 1
    
    class func message(message:String)
    {
        DispatchQueue.main.async
        {
            let alert:VAlert = VAlert(
                message:message)
            
            let rootView:UIView = UIApplication.shared.keyWindow!.rootViewController!.view
            rootView.addSubview(alert)
            
            let views:[String:UIView] = [
                "alert":alert]
            
            let metrics:[String:CGFloat] = [
                "marginTop":kMarginTop,
                "marginHorizontal":kMarginHorizontal,
                "height":kHeight]
            
            rootView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:"H:|-(marginHorizontal)-[alert]-(marginHorizontal)-|",
                options:[],
                metrics:metrics,
                views:views))
            rootView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:"V:[alert(height)]",
                options:[],
                metrics:metrics,
                views:views))
            
            alert.layoutTop = NSLayoutConstraint(
                item:alert,
                attribute:NSLayoutAttribute.top,
                relatedBy:NSLayoutRelation.equal,
                toItem:rootView,
                attribute:NSLayoutAttribute.top,
                multiplier:1,
                constant:-kHeight)
            
            rootView.addConstraint(alert.layoutTop)
            rootView.setNeedsLayout()
            alert.animate(open:true)
        }
    }
    
    convenience init(message:String)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:0, alpha:0.5).cgColor
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let blur:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blur.isUserInteractionEnabled = false
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.medium(size:kFontSize)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.text = message
        
        addSubview(blur)
        addSubview(label)
        
        let views:[String:UIView] = [
            "blur":blur,
            "label":label]
        
        let metrics:[String:CGFloat] = [
            "labelMargin":kLabelMargin
        ]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(labelMargin)-[label]-(labelMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(labelMargin)-[label]-(labelMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    func timeOut(sender timer:Timer)
    {
        timer.invalidate()
        animate(open:false)
    }
    
    //MARK: public
    
    func animate(open:Bool)
    {
        if open
        {
            layoutTop.constant = VAlert.kMarginTop
        }
        else
        {
            layoutTop.constant = -VAlert.kHeight
        }
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.layoutIfNeeded()
            
        })
        { [weak self] (done) in
        
            if open
            {
                guard
                    
                    let timeOut:TimeInterval = self?.kTimeOut
                
                else
                {
                    return
                }
                
                Timer.scheduledTimer(
                    timeInterval:timeOut,
                    target:self,
                    selector:#selector(self?.timeOut(sender:)),
                    userInfo:nil,
                    repeats:false)
            }
        }
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
