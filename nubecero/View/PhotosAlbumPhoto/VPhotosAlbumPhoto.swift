import UIKit

class VPhotosAlbumPhoto:UIView
{
    private weak var controller:CPhotosAlbumPhoto!
    
    convenience init(controller:CPhotosAlbumPhoto)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
