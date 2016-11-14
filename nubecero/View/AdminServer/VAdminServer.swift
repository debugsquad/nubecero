import UIKit

class VAdminServer:UIView
{
    private weak var controller:CAdminServer!
    
    convenience init(controller:CAdminServer)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
