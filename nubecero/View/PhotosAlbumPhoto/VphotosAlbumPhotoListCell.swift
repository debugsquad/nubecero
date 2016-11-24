import UIKit

class VPhotosAlbumPhotoListCell:UICollectionViewCell
{
    private weak var controller:CPhotosAlbumPhoto?
    private weak var scrollView:UIScrollView!
    private weak var model:MPhotosItemPhoto?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedImageLoaded(sender:)),
            name:Notification.imageDataLoaded,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notified
    
    func notifiedImageLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            guard
                
                let picture:MPhotosItemPhoto = notification.object as? MPhotosItemPhoto
                
            else
            {
                return
            }
            
            if picture === self?.model
            {
                self?.imageView.image = picture.resources.image
            }
        }
    }
    
    //MARK: public
    
    func config(controller:CPhotosAlbumPhoto, model:MPhotosItemPhoto)
    {
        self.controller = controller
        self.model = model
        /*
 
         let imageView:UIImageView = UIImageView()
         imageView.isUserInteractionEnabled = false
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.clipsToBounds = true
         imageView.contentMode = UIViewContentMode.scaleAspectFill
         imageView.image = controller.model.state?.loadImage()
         self.imageView = imageView
 */
    }
}
