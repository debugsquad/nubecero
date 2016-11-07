import UIKit

class VAlert:UIView
{
    static let kMarginHorizontal:CGFloat = 10
    static let kHeight:CGFloat = 70
    private weak var layoutTop:NSLayoutConstraint!
    private weak var timer:Timer?
    private let kMarginTop:CGFloat = 20
    private let kAnimationDuration:TimeInterval = 0.2
    private let kTimeOut:TimeInterval = 6
    private let kFontSize:CGFloat = 14
    private let kLabelMargin:CGFloat = 10
    private let kCornerRadius:CGFloat = 5
    private let kBorderWidth:CGFloat = 0.5
    private let kHeaderHeight:CGFloat = 10
    
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
            rootView.layoutIfNeeded()
            alert.animate(open:true)
        }
    }
    
    private convenience init(message:String)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:0, alpha:0.6).cgColor
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let blur:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blur.isUserInteractionEnabled = false
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        let header:UIView = UIView()
        header.isUserInteractionEnabled = false
        header.backgroundColor = UIColor.complement
        header.translatesAutoresizingMaskIntoConstraints = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.medium(size:kFontSize)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.text = message
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(blur)
        addSubview(header)
        addSubview(label)
        addSubview(button)
        
        let views:[String:UIView] = [
            "blur":blur,
            "label":label,
            "button":button,
            "header":header]
        
        let metrics:[String:CGFloat] = [
            "labelMargin":kLabelMargin,
            "headerHeight":kHeaderHeight
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
            withVisualFormat:"H:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[header]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[header(headerHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(headerHeight)-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    func alertTimeOut(sender timer:Timer?)
    {
        timer?.invalidate()
        animate(open:false)
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        timer?.invalidate()
        alertTimeOut(sender:timer)
    }
    
    //MARK: private
    
    private func scheduleTimer()
    {
        self.timer = Timer.scheduledTimer(
            timeInterval:kTimeOut,
            target:self,
            selector:#selector(alertTimeOut(sender:)),
            userInfo:nil,
            repeats:false)
    }
    
    private func animate(open:Bool)
    {
        if open
        {
            layoutTop.constant = kMarginTop
        }
        else
        {
            layoutTop.constant = -VAlert.kHeight
        }
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.superview?.layoutIfNeeded()
            
        })
        { [weak self] (done) in
        
            if open
            {
                self?.scheduleTimer()
            }
            else
            {
                self?.removeFromSuperview()
            }
        }
    }
}
