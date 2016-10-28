import UIKit

class VAlert:UIView
{
    static let kMarginTop:CGFloat = 10
    static let kMarginHorizontal:CGFloat = 10
    static let kHeight:CGFloat = 60
    
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
        }
    }
    
    convenience init(message:String)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.complement
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
}
