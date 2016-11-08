import UIKit

class VOnboard:UIView
{
    weak var controller:COnboard!
    
    convenience init(controller:COnboard)
    {
        self.init()
        backgroundColor = UIColor.complement
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
    }
}
