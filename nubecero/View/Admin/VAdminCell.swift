import UIKit

class VAdminCell:UICollectionViewCell
{
    weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:15)
        label.textColor = UIColor.black
        label.isUserInteractionEnabled = false
        self.label = label
        
        addSubview(label)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MAdminItem)
    {
        
    }
}
