import UIKit

class VPhotosHeader:UICollectionReusableView
{
    private weak var controller:CPhotos?
    private let kAddSize:CGFloat = 55
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonAdd:VPhotosHeaderAdd = VPhotosHeaderAdd(header:self)
        
        addSubview(buttonAdd)
        
        let views:[String:UIView] = [
            "buttonAdd":buttonAdd]
        
        let metrics:[String:CGFloat] = [
            "addSize":kAddSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[buttonAdd(addSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonAdd(addSize)]-10-|",
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
