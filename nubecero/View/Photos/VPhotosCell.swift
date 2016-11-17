import UIKit

class VPhotosCell:UICollectionViewCell
{
    private weak var labelName:UILabel!
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetPhotosAlbum")
        
        let labelName:UILabel = UILabel()
        labelName.isUserInteractionEnabled = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.backgroundColor = UIColor.clear
        labelName.font = UIFont.regular(size:18)
        labelName.textColor = UIColor(white:0.5, alpha:1)
        self.labelName = labelName
        
        addSubview(labelName)
        addSubview(icon)
        
        let views:[String:UIView] = [
            "labelName":labelName,
            "icon":icon]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-[icon(50)]-[labelName]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[labelName(22)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[icon(42)]",
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
            backgroundColor = UIColor.clear
            alpha = kAlphaSelected
        }
        else
        {
            backgroundColor = UIColor.white
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MPhotosItem)
    {
        labelName.text = model.name
        hover()
    }
}
