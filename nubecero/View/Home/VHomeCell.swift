import UIKit

class VHomeCell:UICollectionViewCell
{
    weak var controller:CHome?
    private let kAlphaSelected:CGFloat = 0.3
    private let kAlphaNotSelected:CGFloat = 1
    
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
    
    func config(controller:CHome, model:MHomeItem)
    {
        self.controller = controller
    }
}
