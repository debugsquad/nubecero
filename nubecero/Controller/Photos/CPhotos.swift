import UIKit

class CPhotos:CController
{
    private weak var viewPhotos:VPhotos!
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedPhotosLoaded(sender:)),
            name:Notification.photosLoaded,
            object:nil)
    }
    
    override func loadView()
    {
        let viewPhotos:VPhotos = VPhotos(controller:self)
        self.viewPhotos = viewPhotos
        view = viewPhotos
    }
    
    //MARK: notified
    
    func notifiedPhotosLoaded(sender notification:Notification)
    {
        
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
