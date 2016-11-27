import UIKit

class VHomeUploadCellClouded:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var baseBlur:UIView!
    private weak var indicator:UIImageView!
    private let kBorderWidth:CGFloat = 1
    private let kBlurAlpha:CGFloat = 0.99
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        let baseBlur:UIView = UIView()
        baseBlur.isUserInteractionEnabled = false
        baseBlur.translatesAutoresizingMaskIntoConstraints = false
        baseBlur.clipsToBounds = true
        self.baseBlur = baseBlur
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blur:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blur.isUserInteractionEnabled = false
        blur.clipsToBounds = true
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        let indicator:UIImageView = UIImageView()
        indicator.isUserInteractionEnabled = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.clipsToBounds = true
        indicator.contentMode = UIViewContentMode.center
        indicator.image = #imageLiteral(resourceName: "assetHomeUploadSelect")
        self.indicator = indicator
        
        baseBlur.addSubview(blur)
        addSubview(imageView)
        addSubview(baseBlur)
        addSubview(indicator)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "blur":blur,
            "baseBlur":baseBlur,
            "indicator":indicator]
        
        let metrics:[String:CGFloat] = [
            "indicatorSize":kIndicatorSize]
        
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
            withVisualFormat:"H:|-0-[baseBlur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[baseBlur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[indicator(indicatorSize)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[indicator(indicatorSize)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            baseBlur.alpha = kBlurAlpha
            indicator.isHidden = false
        }
        else
        {
            baseBlur.alpha = 0
            indicator.isHidden = true
        }
    }
    
    //MARK: public
    
    func config(model:MHomeUploadItem)
    {
        imageView.image = model.image
        hover()
    }
}
