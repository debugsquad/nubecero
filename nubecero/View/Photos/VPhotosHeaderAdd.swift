import UIKit

class VPhotosHeaderAdd:UIButton
{
    private weak var header:VPhotosHeader!
    private let kCornerRadius:CGFloat = 4
    
    convenience init(header:VPhotosHeader)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        self.header = header
        
        let image:UIImageView = UIImageView()
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        image.image = #imageLiteral(resourceName: "assetPhotosAlbumAdd").withRenderingMode(
            UIImageRenderingMode.alwaysTemplate)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = false
        
        addSubview(image)
        
        let views:[String:UIView] = [
            "image":image]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        hover()
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
            backgroundColor = UIColor(white:0, alpha:0.2)
        }
        else
        {
            backgroundColor = UIColor.complement
        }
    }
}
