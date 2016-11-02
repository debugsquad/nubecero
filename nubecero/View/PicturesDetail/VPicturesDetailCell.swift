import UIKit

class VPicturesDetailCell:UICollectionViewCell
{
    weak var controller:CPictures?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CPictures)
    {
        self.controller = controller
    }
}
