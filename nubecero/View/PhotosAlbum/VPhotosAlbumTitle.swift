import UIKit

class VPhotosAlbumTitle:UIView
{
    private weak var controller:CPhotosAlbum!
    private weak var labelInfo:UILabel!
    private let kContentWidth:CGFloat = 310
    private let kContentHeight:CGFloat = 70
    
    convenience init(controller:CPhotosAlbum)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let labelName:UILabel = UILabel()
        labelName.isUserInteractionEnabled = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.backgroundColor = UIColor.clear
        labelName.font = UIFont.regular(size:22)
        labelName.textColor = UIColor(white:0.2, alpha:1)
        labelName.text = controller.model.name
        
        let labelInfo:UILabel = UILabel()
        labelInfo.isUserInteractionEnabled = false
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.backgroundColor = UIColor.clear
        labelInfo.font = UIFont.regular(size:13)
        labelInfo.textColor = UIColor(white:0.5, alpha:1)
        self.labelInfo = labelInfo
        
        addSubview(labelName)
        addSubview(labelInfo)
        
        let views:[String:UIView] = [
            "labelName":labelName,
            "labelInfo":labelInfo]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelName]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelInfo]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelName(30)]-0-[labelInfo(20)]-10-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override var intrinsicContentSize:CGSize
    {
        get
        {
            let size:CGSize = CGSize(width:kContentWidth, height:kContentHeight)
            
            return size
        }
    }
    
    //MARK: public
    
    func print()
    {
        
    }
}
