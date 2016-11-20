import UIKit

class VHomeUploadSyncCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var imageStatus:UIImageView!
    private let kStatusSize:CGFloat = 50
    private let kCornerRadius:CGFloat = 5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        layer.cornerRadius = kCornerRadius
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        let imageStatus:UIImageView = UIImageView()
        imageStatus.isUserInteractionEnabled = false
        imageStatus.translatesAutoresizingMaskIntoConstraints = false
        imageStatus.clipsToBounds = true
        imageStatus.contentMode = UIViewContentMode.center
        self.imageStatus = imageStatus
        
        addSubview(imageView)
        addSubview(imageStatus)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "imageStatus":imageStatus]
        
        let metrics:[String:CGFloat] = [
            "statusSize":kStatusSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:
            "H:[imageStatus(statusSize)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:
            "H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:
            "V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[imageStatus(statusSize)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MHomeUploadItem)
    {
        imageView.image = model.image
        imageStatus.image = UIImage(
            named:model.status.assetSync)
    }
}
