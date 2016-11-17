import UIKit

class VPhotosHeader:UICollectionReusableView
{
    private weak var controller:CPhotos?
    
    override init(frame:CGRect)
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
    
    func config(controller:CPhotos)
    {
        self.controller = controller
    }
}
