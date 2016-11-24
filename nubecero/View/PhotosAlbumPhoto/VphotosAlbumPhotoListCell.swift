import UIKit

class VPhotosAlbumPhotoListCell:UICollectionViewCell
{
    private weak var controller:CPhotosAlbumPhoto?
    private weak var image:VPhotosAlbumPhotoListCellImage!
    private weak var model:MPhotosItemPhoto?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let image:VPhotosAlbumPhotoListCellImage = VPhotosAlbumPhotoListCellImage()
        self.image = image

        addSubview(image)
        
        let views:[String:UIView] = [
            "image":image]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
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
                self?.placeImage()
            }
        }
    }
    
    //MARK: private
    
    private func placeImage()
    {
        image.imageView.image = model?.state?.loadImage()
    }
    
    //MARK: public
    
    func config(controller:CPhotosAlbumPhoto, model:MPhotosItemPhoto)
    {
        self.controller = controller
        self.model = model
        placeImage()
    }
}
