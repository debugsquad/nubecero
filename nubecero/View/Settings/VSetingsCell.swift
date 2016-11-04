import UIKit

class VSettingsCell:UICollectionViewCell
{
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
    
    //MARK: public
    
    func config(model:MSettingsItem)
    {
        
    }
}
