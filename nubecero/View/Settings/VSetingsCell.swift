import UIKit

class VSettingsCell:UICollectionViewCell
{
    private let kAlphaSelected:CGFloat = 0.2
    
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
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
        }
        else
        {
            alpha = 1
        }
    }
    
    //MARK: public
    
    func config(model:MSettingsItem)
    {
        
    }
}
