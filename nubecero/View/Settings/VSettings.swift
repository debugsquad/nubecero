import UIKit

class VSettings:UIView
{
    private weak var controller:CSettings!
    
    convenience init(controller:CSettings)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
