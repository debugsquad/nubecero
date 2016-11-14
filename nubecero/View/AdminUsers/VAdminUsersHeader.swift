import UIKit

class VAdminUsersHeader:UICollectionReusableView
{
    private weak var controller:CAdminUsers!
    private weak var labelUsers:UILabel!
    private let numberFormatter:NumberFormatter
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textColor = UIColor(white:0.7, alpha:1)
        labelTitle.text = NSLocalizedString("VAdminUsersHeader_labelTitle", comment:"")
        
        let labelUsers:UILabel = UILabel()
        labelUsers.translatesAutoresizingMaskIntoConstraints = false
        labelUsers.backgroundColor = UIColor.clear
        labelUsers.isUserInteractionEnabled = false
        labelUsers.font = UIFont.medium(size:15)
        labelUsers.textColor = UIColor(white:0.5, alpha:1)
        self.labelUsers = labelUsers
        
        addSubview(labelTitle)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelUsers":labelUsers]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelTitle(70)]-0-[labelUsers(70)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelTitle(40)]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelUsers(40)]-10-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CAdminUsers)
    {
        self.controller = controller
        
        guard
        
            let count:NSNumber = controller.model?.items.count as? NSNumber
        
        else
        {
            return
        }
        
        let stringCount:String? = numberFormatter.string(from:count)
        labelUsers.text = stringCount
    }
}
