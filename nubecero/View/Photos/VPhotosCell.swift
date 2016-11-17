import UIKit

class VPhotosCell:UICollectionViewCell
{
    private weak var labelName:UILabel!
    private weak var labelCount:UILabel!
    private let numberFormatter:NumberFormatter
    private let kAlphaSelected:CGFloat = 0.4
    private let kAlphaNotSelected:CGFloat = 1
    private let kKiloBytesPerMega:CGFloat = 1000
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
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
        labelName.textColor = UIColor(white:0.4, alpha:1)
        self.labelName = labelName
        
        let labelCount:UILabel = UILabel()
        labelCount.isUserInteractionEnabled = false
        labelCount.translatesAutoresizingMaskIntoConstraints = false
        labelCount.backgroundColor = UIColor.clear
        labelCount.font = UIFont.regular(size:13)
        labelCount.textColor = UIColor(white:0.6, alpha:1)
        self.labelCount = labelCount
        
        addSubview(labelName)
        addSubview(labelCount)
        addSubview(icon)
        
        let views:[String:UIView] = [
            "labelName":labelName,
            "labelCount":labelCount,
            "icon":icon]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[icon(44)]-3-[labelName]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[icon]-3-[labelCount(260)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-5-[labelName(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelCount(18)]-14-|",
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
        
        let count:NSNumber = model.references.count as NSNumber
        let megaBytesFloat:CGFloat = CGFloat(model.kiloBytes) / kKiloBytesPerMega
        let megaBytes:NSNumber = megaBytesFloat as NSNumber
        
        guard
            
            let countString:String = numberFormatter.string(from:count),
            let megaBytesString:String = numberFormatter.string(from:megaBytes)
        
        else
        {
            return
        }
        
        let compositeString:String = String(
            format:"%@ Photos  %@ Mb",
            countString,
            megaBytesString)
        
        labelCount.text = compositeString
    }
}
