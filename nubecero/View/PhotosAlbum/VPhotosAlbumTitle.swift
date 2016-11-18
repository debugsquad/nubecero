import UIKit

class VPhotosAlbumTitle:UIView
{
    private weak var controller:CPhotosAlbum!
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
        
        let imagePictures:UIImageView = UIImageView()
        imagePictures.isUserInteractionEnabled = false
        imagePictures.translatesAutoresizingMaskIntoConstraints = false
        imagePictures.clipsToBounds = true
        imagePictures.contentMode = UIViewContentMode.center
        imagePictures.image = #imageLiteral(resourceName: "assetPhotosAlbumPhotos")
        
        addSubview(labelName)
        addSubview(imagePictures)
        
        let views:[String:UIView] = [
            "labelName":labelName,
            "imagePictures":imagePictures]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelName]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-5-[imagePictures(30)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[labelName(30)]-0-[imagePictures(30)]-0-|",
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
}
