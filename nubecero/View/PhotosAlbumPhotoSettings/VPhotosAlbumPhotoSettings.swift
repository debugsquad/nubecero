import UIKit

class VPhotosAlbumPhotoSettings:UIView
{
    private weak var controller:CPhotosAlbumPhotoSettings!
    
    convenience init(controller:CPhotosAlbumPhotoSettings)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
