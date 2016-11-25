import UIKit

class VPhotosAlbumPhotoSettings:UIView
{
    private weak var controller:CPhotosAlbumPhotoSettings!
    private weak var collectionView:UICollectionView!
    
    convenience init(controller:CPhotosAlbumPhotoSettings)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
