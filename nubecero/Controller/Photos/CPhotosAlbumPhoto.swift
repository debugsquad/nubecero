import UIKit

class CPhotosAlbumPhoto:CController
{
    private weak var viewPhoto:VPhotosAlbumPhoto!
    weak var model:MPhotosItemPhoto!
    
    init(model:MPhotosItemPhoto, frame:CGRect)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewPhoto:VPhotosAlbumPhoto = VPhotosAlbumPhoto(controller:self)
        self.viewPhoto = viewPhoto
        view = viewPhoto
    }
}
