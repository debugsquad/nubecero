import UIKit

class VPhotos:UIView
{
    private weak var controller:CPhotos!
    
    convenience init(controller:CPhotos)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
