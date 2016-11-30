import UIKit

class VPhotosAlbumPhotoSettingsCell:UICollectionViewCell
{
    weak var controller:CPhotosAlbumPhotoSettings?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CPhotosAlbumPhotoSettings, model:MPhotosAlbumPhotoSettingsItem)
    {
        self.controller = controller
    }
}
