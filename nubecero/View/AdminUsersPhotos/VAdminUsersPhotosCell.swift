import UIKit

class VAdminUsersPhotosCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var model:MAdminUsersPhotosItem?
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
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
            selector:#selector(notifiedUserPhotoLoaded(sender:)),
            name:Notification.userPhotoLoaded,
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
    
    func notifiedUserPhotoLoaded(sender notification:Notification)
    {
        guard
        
            let notificationModel:MAdminUsersPhotosItem = notification.object as? MAdminUsersPhotosItem
        
        else
        {
            return
        }
        
        DispatchQueue.main.async
        { [weak self] in
                
            if notificationModel === self?.model
            {
                self?.showImage()
            }
        }
    }
    
    //MARK: private
    
    private func showImage()
    {
        imageView.image = model?.modelStatus?.loadImage()
    }
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
            backgroundColor = UIColor.clear
        }
        else
        {
            alpha = kAlphaNotSelected
            backgroundColor = UIColor.white
        }
    }
    
    //MARK: public
    
    func config(model:MAdminUsersPhotosItem)
    {
        self.model = model
        showImage()
        hover()
    }
}
