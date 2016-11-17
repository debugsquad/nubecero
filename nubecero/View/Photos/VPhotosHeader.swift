import UIKit

class VPhotosHeader:UICollectionReusableView
{
    private weak var controller:CPhotos?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonAdd:UIButton = UIButton()
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.setImage(#imageLiteral(resourceName: "assetPhotosAlbumAdd"), for:UIControlState.normal)
        buttonAdd.imageView!.clipsToBounds = true
        buttonAdd.imageView!.contentMode = UIViewContentMode.center
        addSubview(buttonAdd)
        
        let views:[String:UIView] = [
            "buttonAdd":buttonAdd]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[buttonAdd(70)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonAdd]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CPhotos)
    {
        self.controller = controller
    }
}
