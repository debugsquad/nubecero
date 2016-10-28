import UIKit

class VLogin:UIView
{
    weak var controller:CLogin!
    
    convenience init(controller:CLogin)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.main
        self.controller = controller
    }
}
