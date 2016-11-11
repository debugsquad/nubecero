import UIKit
import FirebaseAuth

class VSettingsCellAccount:VSettingsCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        guard
            
            let email:String = FIRAuth.auth()?.currentUser?.email
        
        else
        {
            return
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let attrTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VSettingsCellAccount_title", comment:""),
            attributes:[
                NSFontAttributeName:UIFont.regular(size:13),
                NSForegroundColorAttributeName:UIColor.black
            ])
        let attrEmail:NSAttributedString = NSAttributedString(
            string:email,
            attributes:[
                NSFontAttributeName:UIFont.medium(size:14),
                NSForegroundColorAttributeName:UIColor(white:0.6, alpha:1)
            ])
        
        mutableString.append(attrTitle)
        mutableString.append(attrEmail)
        
        let labelEmail:UILabel = UILabel()
        labelEmail.isUserInteractionEnabled = false
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.backgroundColor = UIColor.clear
        labelEmail.attributedText = mutableString
        
        addSubview(labelEmail)
        
        let views:[String:UIView] = [
            "labelEmail":labelEmail]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-18-[labelEmail]-18-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelEmail]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
