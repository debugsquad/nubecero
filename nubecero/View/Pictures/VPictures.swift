import UIKit

class VPictures:UIView
{
    weak var controller:CPictures!
    
    convenience init(controller:CPictures)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
