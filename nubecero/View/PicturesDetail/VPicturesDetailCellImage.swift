import UIKit

class VPicturesDetailCellImage:VPicturesDetailCell
{
    private weak var imageView:UIImageView!
    private weak var model:MPicturesItem?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedImageDataLoaded(sender:)),
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
    
    override func config(controller:CPictures)
    {
        model = controller.viewPictures.currentItem
        imageView.image = model?.state.loadImage()
    }
    
    //MARK: notified
    
    func notifiedImageDataLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            guard
                
                let picture:MPicturesItem = notification.object as? MPicturesItem
                
            else
            {
                return
            }
            
            if picture === self?.model
            {
                picture.becameActive()
                self?.imageView.image = picture.image
            }
        }
    }
}
