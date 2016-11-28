import UIKit

class VPhotosAlbumSelection:UIView
{
    private weak var controller:CPhotosAlbumSelection!
    
    convenience init(controller:CPhotosAlbumSelection)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        
    }
}
