import UIKit

class VPhotosHeader:UICollectionReusableView
{
    private weak var controller:CPhotos?
    private weak var layoutAddLeft:NSLayoutConstraint!
    private weak var layoutFieldWidth:NSLayoutConstraint!
    private weak var buttonAdd:VPhotosHeaderAdd!
    weak var field:VPhotosHeaderField!
    private var creating:Bool
    private let kAnimationDuration:TimeInterval = 0.3
    private let kAddSize:CGFloat = 55
    private let kAddMargin:CGFloat = 10
    private let kMinFieldWidth:CGFloat = 15
    private let kMaxFieldWidth:CGFloat = 160
    
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
        
        let field:VPhotosHeaderField = VPhotosHeaderField()
        field.alpha = 0
        self.field = field
        
        addSubview(buttonAdd)
        addSubview(field)
        
        let views:[String:UIView] = [
            "buttonAdd":buttonAdd,
            "field":field]
        
        let metrics:[String:CGFloat] = [
            "addSize":kAddSize,
            "addMargin":kAddMargin]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonAdd(addSize)]-(addMargin)-[field]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonAdd(addSize)]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[field(42)]-26-|",
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
        
        layoutFieldWidth = NSLayoutConstraint(
            item:field,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kMinFieldWidth)
        
        addConstraint(layoutAddLeft)
        addConstraint(layoutFieldWidth)
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
        
        let maxFieldWidth:CGFloat = kMaxFieldWidth
        let animationDuration:TimeInterval = kAnimationDuration
        
        UIView.animate(
            withDuration:
            animationDuration,
            animations:
            { [weak self] in
                
                self?.layoutIfNeeded()
                self?.buttonAdd.alpha = 0.2
                self?.field.alpha = 1
            })
        { [weak self] (done:Bool) in
            
            self?.layoutFieldWidth.constant = maxFieldWidth
            
            UIView.animate(
                withDuration:
                animationDuration,
                animations:
                { [weak self] in
                    
                    self?.layoutIfNeeded()
                })
            { [weak self] (done:Bool) in
                
                self?.field.textField.becomeFirstResponder()
            }
        }
    }
    
    //MARK: public
    
    func config(controller:CPhotos)
    {
        self.controller = controller
        field.controller = controller
    }
}
