import UIKit

class CPhotos:CController
{
    private weak var viewPhotos:VPhotos!
    
    override func loadView()
    {
        let viewPhotos:VPhotos = VPhotos(controller:self)
        self.viewPhotos = viewPhotos
        view = viewPhotos
    }
}
