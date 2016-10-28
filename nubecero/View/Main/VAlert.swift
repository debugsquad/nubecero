import UIKit

class VAlert:UIView
{
    static let kMarginTop:CGFloat = 10
    static let kMarginHorizontal:CGFloat = 10
    static let kHeight:CGFloat = 60
    weak var layoutTop:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.4
    
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
        }
    }
    
    convenience init(message:String)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.complement
        translatesAutoresizingMaskIntoConstraints = false
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
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
