import UIKit

class VPhotosHeaderAdd:UIButton
{
    private weak var header:VPhotosHeader!
    
    convenience init(header:VPhotosHeader)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.header = header
        
        let image:UIImageView = UIImageView()
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        image.image = #imageLiteral(resourceName: "assetPhotosAlbumAdd")
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
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let radius:CGFloat = width / 2.0
        layer.cornerRadius = radius
        
        super.layoutSubviews()
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
            backgroundColor = UIColor(white:0, alpha:0.05)
        }
        else
        {
            backgroundColor = UIColor.complement
        }
    }
}
