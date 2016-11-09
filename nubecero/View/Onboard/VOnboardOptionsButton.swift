import UIKit

class VOnboardOptionsButton:UIButton
{
    convenience init(title:String)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.main
        setTitleColor(UIColor.white, for:UIControlState.normal)
        setTitle(
            title,
            for:UIControlState.normal)
        titleLabel!.font = UIFont.medium(size:13)
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
            alpha = 0.8
        }
        else
        {
            alpha = 1
        }
    }
}
