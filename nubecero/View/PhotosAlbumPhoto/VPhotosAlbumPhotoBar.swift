import UIKit

class VPhotosAlbumPhotoBar:UIView
{
    private weak var controller:CPhotosAlbumPhoto!
    
    convenience init(controller:CPhotosAlbumPhoto)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor(white:0, alpha:0.8)
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
