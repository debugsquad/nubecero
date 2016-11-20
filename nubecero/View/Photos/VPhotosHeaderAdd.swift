import UIKit

class VPhotosHeaderAdd:UIButton
{
    private weak var header:VPhotosHeader!
    private weak var image:UIImageView!
    
    convenience init(header:VPhotosHeader)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.header = header
        
        let image:UIImageView = UIImageView()
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        image.image = #imageLiteral(resourceName: "assetPhotosAlbumAdd").withRenderingMode(
            UIImageRenderingMode.alwaysTemplate)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = false
        self.image = image
        
        addSubview(image)
        
        let views:[String:UIView] = [
            "image":image]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[image(50)]",
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
            image.tintColor = UIColor.main
        }
        else
        {
            image.tintColor = UIColor.complement
        }
    }
}
