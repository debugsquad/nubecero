import UIKit

class VPhotosHeaderAdd:UIButton
{
    private weak var header:VPhotosHeader!
    private weak var image:UIImageView!
    private weak var label:UILabel!
    
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
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular(size:14)
        label.text = NSLocalizedString("VPhotosHeaderAdd_label", comment:"")
        self.label = label
        
        addSubview(label)
        addSubview(image)
        
        let views:[String:UIView] = [
            "image":image,
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[image(50)]-0-[label(150)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[label]-0-|",
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
            label.textColor = UIColor.main
            image.tintColor = UIColor.main
        }
        else
        {
            image.tintColor = UIColor.complement
            label.textColor = UIColor(white:0.4, alpha:1)
        }
    }
}
