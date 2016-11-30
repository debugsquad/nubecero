import UIKit

class VPhotosAlbumSelectionCell:UICollectionViewCell
{
    private weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.medium(size:15)
        label.backgroundColor = UIColor.clear
        self.label = label
        
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-20-[label]-20-|",
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
            label.textColor = UIColor.white
            backgroundColor = UIColor.complement
        }
        else
        {
            label.textColor = UIColor(white:0, alpha:0.4)
            backgroundColor = UIColor(white:1, alpha:0.3)
        }
    }
    
    //MARK: public
    
    func config(model:MPhotosItem)
    {
        label.text = model.name
        hover()
    }
}
