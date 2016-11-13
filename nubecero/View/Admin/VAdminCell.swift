import UIKit

class VAdminCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:14)
        label.textColor = UIColor(white:0.4, alpha:1)
        label.isUserInteractionEnabled = false
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
    
    func config(model:MAdminItem)
    {
        label.text = model.title
        hover()
    }
}
