import UIKit

class VPhotosAlbumTitle:UIView
{
    private weak var controller:CPhotosAlbum!
    private let kContentWidth:CGFloat = 300
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
        labelName.font = UIFont.regular(size:20)
        labelName.textColor = UIColor(white:0.2, alpha:1)

        
        addSubview(labelName)
    }
    
    override var intrinsicContentSize:CGSize
    {
        get
        {
            let size:CGSize = CGSize(width:kContentWidth, height:kContentHeight)
            
            return size
        }
    }
}
