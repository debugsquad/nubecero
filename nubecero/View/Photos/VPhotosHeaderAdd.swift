import UIKit

class VPhotosHeaderAdd:UIButton
{
    private weak var controller:CPhotos!
    
    convenience init(controller:CPhotos)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        
    }
}
