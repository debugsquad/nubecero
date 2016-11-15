import UIKit

class VAdminPurchases:UIView
{
    private weak var controller:CAdminPurchases!
    
    convenience init(controller:CAdminPurchases)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
