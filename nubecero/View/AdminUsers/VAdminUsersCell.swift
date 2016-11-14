import UIKit

class VAdminUsersCell:UICollectionViewCell
{
    private weak var labelUserId:UILabel!
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let labelUserId:UILabel = UILabel()
        labelUserId.translatesAutoresizingMaskIntoConstraints = false
        labelUserId.isUserInteractionEnabled = false
        labelUserId.backgroundColor = UIColor.clear
        labelUserId.font = UIFont.medium(size:14)
        labelUserId.textColor = UIColor(white:0.3, alpha:1)
        self.labelUserId = labelUserId
        
        addSubview(labelUserId)
        
        let views:[String:UIView] = [
            "labelUserId":labelUserId]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelUserId(150)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[labelUserId(18)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
            backgroundColor = UIColor.clear
        }
        else
        {
            alpha = kAlphaNotSelected
            backgroundColor = UIColor.white
        }
    }
    
    //MARK: public
    
    func config(model:MAdminUsersItem)
    {
        labelUserId.text = model.userId
    }
}
