import UIKit

class VHomeCellUpload:VHomeCell
{
    private weak var layoutAddLeft:NSLayoutConstraint!
    private let kAddWidth:CGFloat = 150
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let add:VHomeCellUploadAdd = VHomeCellUploadAdd()
        add.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(add)
        
        let views:[String:UIView] = [
            "add":add]
        
        let metrics:[String:CGFloat] = [
            "addWidth":kAddWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[add(addWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[add]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutAddLeft = NSLayoutConstraint(
            item:add,
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
        let width:CGFloat = bounds.size.width
        let remain:CGFloat = width - kAddWidth
        let margin:CGFloat = remain / 2.0
        layoutAddLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionAdd(sender button:UIButton)
    {
        controller?.uploadPictures()
    }
}
