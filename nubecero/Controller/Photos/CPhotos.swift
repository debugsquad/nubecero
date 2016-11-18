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
    
    //MARK: public
    
    func selected(item:MPhotosItem)
    {
        let albumController:CPhotosAlbum = CPhotosAlbum(model:item)
        parentController.scrollRight(
            controller:albumController,
            underBar:false,
            pop:false)
    }
}
