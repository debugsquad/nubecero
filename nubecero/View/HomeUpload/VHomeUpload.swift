import UIKit

class VHomeUpload:UIView
{
    weak var controller:CHomeUpload!
    
    convenience init(controller:CHomeUpload)
    {
        self.init()
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
    }
}
