import UIKit

class VPhotosAlbumCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var model:MPhotosItemPhoto?
    private let kAnimationDuration:TimeInterval = 1.5
    private let kAlphaSelected:CGFloat = 0.3
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(
            red:0.88,
            green:0.91,
            blue:0.93,
            alpha:1)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.borderColor = UIColor.black.cgColor
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
            selector:#selector(notifiedThumbnailReady(sender:)),
            name:Notification.thumbnailReady,
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
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: notified
    
    func notifiedThumbnailReady(sender notification:Notification)
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
                self?.animateLoadThumb()
            }
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    private func animateLoadThumb()
    {
        guard
            
            let image:UIImage = model?.state?.loadThumbnail()
            
        else
        {
            imageView.image = nil
            
            return
        }
        
        imageView.alpha = 0
        imageView.image = image
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.imageView.alpha = 1
        }
    }
    
    //MARK: public
    
    func config(model:MPhotosItemPhoto)
    {
        self.model = model
        animateLoadThumb()
        hover()
    }
}
