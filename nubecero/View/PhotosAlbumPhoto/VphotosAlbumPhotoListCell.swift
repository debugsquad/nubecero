import UIKit

class VPhotosAlbumPhotoListCell:UICollectionViewCell
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var scroll:VPhotosAlbumPhotoListCellImage?
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
                self?.placeImage()
            }
        }
    }
    
    //MARK: private
    
    private func checkScroll()
    {
        if scroll == nil
        {
            let scroll:VPhotosAlbumPhotoListCellImage = VPhotosAlbumPhotoListCellImage(
                controller:controller)
            self.scroll = scroll
            
            addSubview(scroll)
            
            let views:[String:UIView] = [
                "scroll":scroll]
            
            let metrics:[String:CGFloat] = [:]
            
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:"H:|-0-[scroll]-0-|",
                options:[],
                metrics:metrics,
                views:views))
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:"V:|-0-[scroll]-0-|",
                options:[],
                metrics:metrics,
                views:views))
        }
    }
    
    private func placeImage()
    {
        scroll?.imageView.image = model?.state?.loadImage()
    }
    
    //MARK: public
    
    func config(controller:CPhotosAlbumPhoto, model:MPhotosItemPhoto)
    {
        self.controller = controller
        self.model = model
        
        checkScroll()
        placeImage()
    }
}
