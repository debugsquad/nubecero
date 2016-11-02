import UIKit

class VPicturesCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var model:MPicturesItem?
    private let kImageMargin:CGFloat = 2
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "imageMargin":kImageMargin]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(imageMargin)-[imageView]-(imageMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(imageMargin)-[imageView]-(imageMargin)-|",
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
            
                let picture:MPicturesItem = notification.object as? MPicturesItem
            
            else
            {
                return
            }
            
            if picture === self?.model
            {
                self?.config(model:picture)
            }
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            backgroundColor = UIColor.main
        }
        else
        {
            backgroundColor = UIColor(white:0, alpha:0.1)
        }
    }
    
    //MARK: public
    
    func config(model:MPicturesItem)
    {
        self.model = model
        imageView.image = model.state.loadThumbnail()
        hover()
    }
}
