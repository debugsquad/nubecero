import UIKit

class VAdmin:UIView
{
    private weak var controller:CAdmin!
    
    convenience init(controller:CAdmin)
    {
        self.init()
        backgroundColor = UIColor.background
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
