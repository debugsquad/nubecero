import UIKit

class VBanned:UIView
{
    weak var controller:CBanned!
    
    convenience init(controller:CBanned)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.main
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
