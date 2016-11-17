import UIKit

class VPicturesDetailCellImage:VPicturesDetailCell
{
    private weak var imageView:UIImageView!
    private weak var model:MPicturesItem?
    private let kAnimationDuration:TimeInterval = 0.5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor(red:0.97, green:0.98, blue:0.995, alpha:1)
        
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
        animateLoadImage()
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
                self?.animateLoadImage()
            }
        }
    }
    
    //MARK: private
    
    private func animateLoadImage()
    {
        guard
            
            let image:UIImage = model?.image
            
        else
        {
            imageView.image = model?.state.loadImage()
            
            return
        }
        
        imageView.alpha = 0
        imageView.image = image
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.imageView.alpha = 1
        }
    }
}
