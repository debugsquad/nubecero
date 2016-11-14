import UIKit

class VAdminUsersCell:UICollectionViewCell
{
    private weak var labelUserId:UILabel!
    private weak var labelCreated:UILabel!
    private weak var labelLastSession:UILabel!
    private weak var labelDiskUsed:UILabel!
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
        labelUserId.textColor = UIColor.black
        self.labelUserId = labelUserId
        
        let labelCreated:UILabel = UILabel()
        labelCreated.translatesAutoresizingMaskIntoConstraints = false
        labelCreated.isUserInteractionEnabled = false
        labelCreated.backgroundColor = UIColor.clear
        labelCreated.font = UIFont.regular(size:14)
        labelCreated.textColor = UIColor(white:0.4, alpha:1)
        self.labelCreated = labelCreated
        
        let labelLastSession:UILabel = UILabel()
        labelLastSession.translatesAutoresizingMaskIntoConstraints = false
        labelLastSession.isUserInteractionEnabled = false
        labelLastSession.backgroundColor = UIColor.clear
        labelLastSession.font = UIFont.regular(size:14)
        labelLastSession.textColor = UIColor(white:0.4, alpha:1)
        self.labelLastSession = labelLastSession
        
        let labelDiskUsed:UILabel = UILabel()
        labelDiskUsed.translatesAutoresizingMaskIntoConstraints = false
        labelDiskUsed.isUserInteractionEnabled = false
        labelDiskUsed.backgroundColor = UIColor.clear
        labelDiskUsed.font = UIFont.numeric(size:18)
        labelDiskUsed.textColor = UIColor.main
        self.labelDiskUsed = labelDiskUsed
        
        addSubview(labelUserId)
        addSubview(labelCreated)
        addSubview(labelLastSession)
        addSubview(labelDiskUsed)
        
        let views:[String:UIView] = [
            "labelUserId":labelUserId,
            "labelCreated":labelCreated,
            "labelLastSession":labelLastSession,
            "labelDiskUsed":labelDiskUsed]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelUserId]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelCreated]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelLastSession]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelDiskUsed]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[labelUserId(18)]-0-[labelCreated(17)]-0-[labelLastSession(17)]-0-[labelDiskUsed(22)]",
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
