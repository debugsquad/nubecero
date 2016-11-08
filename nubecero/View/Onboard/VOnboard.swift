import UIKit

class VOnboard:UIView
{
    weak var controller:COnboard!
    
    convenience init(controller:COnboard)
    {
        self.init()
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
    }
}
