import UIKit

class VPicturesDataCell:UICollectionViewCell
{
    weak var controller:CPicturesData?
    weak var model:MPicturesDataItem?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CPicturesData, model:MPicturesDataItem)
    {
        self.controller = controller
        self.model = model
    }
}
