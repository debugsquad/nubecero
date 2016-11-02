import UIKit

class VPicturesCell:UICollectionViewCell
{
    private weak var blurView:UIView!
    private weak var imageView:UIImageView!
    private weak var model:MPicturesItem?
    private let kBlurAlpha:CGFloat = 0.7
    private let kBorderWidth:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let blur:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blur.isUserInteractionEnabled = false
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.clipsToBounds = true
        
        let blurView:UIView = UIView()
        blurView.isUserInteractionEnabled = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.clipsToBounds = true
        blurView.alpha = kBlurAlpha
        self.blurView = blurView
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.borderColor = UIColor.black.cgColor
        self.imageView = imageView
        
        blurView.addSubview(blur)
        addSubview(imageView)
        addSubview(blurView)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "blur":blur,
            "blurView":blurView]
        
        let metrics:[String:CGFloat] = [
            "borderWidth":kBorderWidth]
        
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
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(borderWidth)-[blurView]-(borderWidth)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(borderWidth)-[blurView]-0-|",
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
            blurView.isHidden = false
            imageView.layer.borderWidth = kBorderWidth
        }
        else
        {
            blurView.isHidden = true
            imageView.layer.borderWidth = 0
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
