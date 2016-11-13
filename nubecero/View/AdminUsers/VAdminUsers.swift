import UIKit

class VAdminUsers:UIView
{
    private weak var controller:CAdminUsers!
    
    convenience init(controller:CAdminUsers)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
