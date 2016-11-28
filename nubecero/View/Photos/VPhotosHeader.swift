import UIKit

class VPhotosHeader:UICollectionReusableView
{
    private weak var controller:CPhotos?
    private weak var layoutAddLeft:NSLayoutConstraint!
    private weak var buttonAdd:VPhotosHeaderAdd!
    private weak var textField:UITextField!
    private var creating:Bool
    private let kAnimationDuration:TimeInterval = 0.3
    private let kAddSize:CGFloat = 55
    private let kAddMargin:CGFloat = 10
    
    override init(frame:CGRect)
    {
        creating = false
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonAdd:VPhotosHeaderAdd = VPhotosHeaderAdd(header:self)
        buttonAdd.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonAdd = buttonAdd
        
        
        
        addSubview(buttonAdd)
        
        let views:[String:UIView] = [
            "buttonAdd":buttonAdd]
        
        let metrics:[String:CGFloat] = [
            "addSize":kAddSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonAdd(addSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonAdd(addSize)]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutAddLeft = NSLayoutConstraint(
            item:buttonAdd,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutAddLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        if !creating
        {
            let width:CGFloat = bounds.maxX
            let remain:CGFloat = width - kAddSize
            let margin:CGFloat = remain / 2.0
            layoutAddLeft.constant = margin
        }
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionAdd(sender button:UIButton)
    {
        buttonAdd.isUserInteractionEnabled = false
        creating = true
        layoutAddLeft.constant = kAddMargin
        
        UIView.animate(
            withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: public
    
    func config(controller:CPhotos)
    {
        self.controller = controller
    }
}
