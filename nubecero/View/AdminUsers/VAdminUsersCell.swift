import UIKit

class VAdminUsersCell:UICollectionViewCell
{
    private let dateFormatter:DateFormatter
    private let numberFormatter:NumberFormatter
    private weak var labelUserId:UILabel!
    private weak var labelCreated:UILabel!
    private weak var labelLastSession:UILabel!
    private weak var labelStatus:UILabel!
    private weak var labelDiskUsed:UILabel!
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    private let kKilobytesPerMega:CGFloat = 1000
    private let kMaxFractions:Int = 3
    
    override init(frame:CGRect)
    {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxFractions
        
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
        labelDiskUsed.font = UIFont.numeric(size:15)
        labelDiskUsed.textColor = UIColor.main
        self.labelDiskUsed = labelDiskUsed
        
        let labelStatus:UILabel = UILabel()
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        labelStatus.isUserInteractionEnabled = false
        labelStatus.backgroundColor = UIColor.clear
        labelStatus.font = UIFont.bold(size:14)
        labelStatus.textColor = UIColor.complement
        self.labelStatus = labelStatus
        
        addSubview(labelUserId)
        addSubview(labelCreated)
        addSubview(labelLastSession)
        addSubview(labelDiskUsed)
        addSubview(labelStatus)
        
        let views:[String:UIView] = [
            "labelUserId":labelUserId,
            "labelCreated":labelCreated,
            "labelLastSession":labelLastSession,
            "labelStatus":labelStatus,
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
            withVisualFormat:"H:|-10-[labelStatus]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[labelUserId(18)]-2-[labelCreated(17)]-0-[labelLastSession(17)]-10-[labelStatus(18)]-5-[labelDiskUsed(20)]",
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
        
        let dateCreated:Date = Date(timeIntervalSince1970:model.created)
        let dateLastSession:Date = Date(timeIntervalSince1970:model.lastSession)
        let numberDiskUsed:NSNumber = (CGFloat(model.diskUsed) / kKilobytesPerMega) as NSNumber
        let stringCreated:String = dateFormatter.string(from:dateCreated)
        let stringLastSession:String = dateFormatter.string(from:dateLastSession)
        let stringDiskUsed:String = numberFormatter.string(from:numberDiskUsed)!
        let createdComposite:String = String(
            format:NSLocalizedString("VAdminUsersCell_labelCreated", comment:""),
            stringCreated)
        let lastSessionComposite:String = String(
            format:NSLocalizedString("VAdminUsersCell_labelLastSession", comment:""),
            stringLastSession)
        let diskUsedComposite:String = String(
            format:NSLocalizedString("VAdminUsersCell_labelDiskUsed", comment:""),
            stringDiskUsed)
        let stringStatus:String
        
        switch model.status
        {
            case FDatabaseModelUser.Status.active:
                
                stringStatus = NSLocalizedString("VAdminUsersCell_labelStatusActive", comment:"")
            
                break
            
            case FDatabaseModelUser.Status.banned:
                
                stringStatus = NSLocalizedString("VAdminUsersCell_labelStatusBanned", comment:"")
                
                break
                
            case FDatabaseModelUser.Status.unknown:
                
                stringStatus = NSLocalizedString("VAdminUsersCell_labelStatusUnknown", comment:"")
                
                break
        }
        
        labelCreated.text = createdComposite
        labelLastSession.text = lastSessionComposite
        labelDiskUsed.text = diskUsedComposite
        labelStatus.text = stringStatus
        
        hover()
    }
}
