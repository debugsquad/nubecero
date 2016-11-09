import UIKit

class VOnboardFormSender:UIView
{
    private weak var controller:COnboardForm!
    
    convenience init(controller:COnboardForm)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.complement
    }
}
