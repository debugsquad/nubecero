import UIKit

class VHomeCellUploadAdd:UIButton
{
    private weak var base:UIView!
    private weak var image:UIImageView!
    private weak var label:UILabel!
    private weak var layoutBaseLeft:NSLayoutConstraint!
    private let kBaseSize:CGFloat = 80
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let base:UIView = UIView()
        base.isUserInteractionEnabled = false
        base.clipsToBounds = true
        base.translatesAutoresizingMaskIntoConstraints = false
        base.layer.cornerRadius = kBaseSize / 2.0
        base.layer.borderColor = UIColor(white:0, alpha:0.2).cgColor
        self.base = base
        
        let image:UIImageView = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "assetHomeUpload")
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        self.image = image
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:13)
        label.text = NSLocalizedString("VHomeCellUploadAdd_label", comment:"")
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        base.addSubview(image)
        addSubview(base)
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label,
            "image":image,
            "base":base]
        
        let metrics:[String:CGFloat] = [
            "baseSize":kBaseSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[base[baseSize]]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[base[baseSize]]-0-[label(20)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBaseLeft = NSLayoutConstraint(
            item:base,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBaseLeft)
        
        hover()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainWidth:CGFloat = width - kBaseSize
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutBaseLeft.constant = marginLeft
        
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
            base.backgroundColor = UIColor(white:0, alpha:0.1)
            base.layer.borderWidth = 1
            label.textColor = UIColor(white:0, alpha:0.2)
        }
        else
        {
            base.backgroundColor = UIColor.complement
            base.layer.borderWidth = 0
            label.textColor = UIColor.complement
        }
    }
}
