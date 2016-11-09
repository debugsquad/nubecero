import UIKit

class VOnboardFormSender:UIView
{
    private weak var controller:COnboardForm!
    private let kCornerRadius:CGFloat = 4
    
    convenience init(controller:COnboardForm)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        self.controller = controller
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:0, alpha:0.3)
        
        let button:UIButton = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = UIColor.complement
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = kCornerRadius
        
        addSubview(border)
    }
}
