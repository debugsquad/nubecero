import UIKit

class VHomeUploadSyncCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var imageStatus:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
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
        
        let shade:UIView = UIView()
        shade.isUserInteractionEnabled = false
        shade.clipsToBounds = true
        shade.backgroundColor = UIColor(white:1, alpha:0.8)
        shade.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(shade)
        addSubview(imageStatus)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "imageStatus":imageStatus,
            "shade":shade]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:
            "H:|-0-[imageStatus]-0-|",
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
            withVisualFormat:"H:|-3-[shade]-3-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-3-[shade]-3-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageStatus]-0-|",
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
