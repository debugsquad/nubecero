import UIKit

class VAdminUsersPhotosCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.white
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MAdminUsersPhotosItem)
    {
        
    }
}
