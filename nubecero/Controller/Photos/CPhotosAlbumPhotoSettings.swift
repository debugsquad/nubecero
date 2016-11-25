import UIKit

class CPhotosAlbumPhotoSettings:CController
{
    private weak var viewSettings:VPhotosAlbumPhotoSettings!
    private weak var model:MPhotosItemPhoto?
    
    convenience init(model:MPhotosItemPhoto)
    {
        self.init()
        self.model = model
    }
    
    override func loadView()
    {
        let viewSettings:VPhotosAlbumPhotoSettings = VPhotosAlbumPhotoSettings(
            controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop()
    }
    
    func deletePhoto()
    {
        
    }
}
