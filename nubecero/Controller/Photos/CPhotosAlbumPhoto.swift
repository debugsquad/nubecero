import UIKit

class CPhotosAlbumPhoto:CController
{
    private weak var viewPhoto:VPhotosAlbumPhoto!
    
    override func loadView()
    {
        let viewPhoto:VPhotosAlbumPhoto = VPhotosAlbumPhoto(controller:self)
        self.viewPhoto = viewPhoto
        view = viewPhoto
    }
}
