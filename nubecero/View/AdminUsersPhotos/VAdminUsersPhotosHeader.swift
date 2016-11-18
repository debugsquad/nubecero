import UIKit

class VAdminUsersPhotosHeader:UICollectionReusableView
{
    private weak var label:UILabel!
    private let numberFormatter:NumberFormatter
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:17)
        label.textColor = UIColor.complement
        self.label = label
        
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CAdminUsersPhotos)
    {
        guard
            
            let count:Int = controller.photos?.items.count,
            let countString:String = numberFormatter.string(from:count as NSNumber)
        
        else
        {
            return
        }
        
        let compositeString:String = String(
            format:NSLocalizedString("VAdminUsersPhotosHeader_titleLabel", comment:""),
            countString)
        label.text = compositeString
    }
}
