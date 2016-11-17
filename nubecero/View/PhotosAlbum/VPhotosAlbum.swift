import UIKit

class VPhotosAlbum:UIView
{
    private weak var controller:CPhotosAlbum!
    
    convenience init(controller:CPhotosAlbum)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
