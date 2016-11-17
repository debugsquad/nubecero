import UIKit

class CPhotosAlbum:CController
{
    private weak var viewAlbum:VPhotosAlbum!
    
    override func loadView()
    {
        let viewAlbum:VPhotosAlbum = VPhotosAlbum(controller:self)
        self.viewAlbum = viewAlbum
        view = viewAlbum
    }
}
