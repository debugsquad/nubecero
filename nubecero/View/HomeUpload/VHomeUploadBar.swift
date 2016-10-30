import UIKit

class VHomeUploadBar:UIView
{
    weak var controller:CHomeUpload!
    
    convenience init(controller:CHomeUpload)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
