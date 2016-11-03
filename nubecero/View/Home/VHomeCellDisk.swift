import UIKit

class VHomeCellDisk:VHomeCell
{
    private let kCircleSize:CGFloat = 200
    private weak var layoutCircleLeft:NSLayoutConstraint!
    private weak var layoutCircleTop:NSLayoutConstraint!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let circle:VHomeCellDiskCircle = VHomeCellDiskCircle()
        let gradient:VHomeCellDiskGradient = VHomeCellDiskGradient()
        
        addSubview(gradient)
//        addSubview(circle)
        
        let views:[String:UIView] = [
            "circle":circle,
            "gradient":gradient]
        
        let metrics:[String:CGFloat] = [
            "circleSize":kCircleSize]
        
//        addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat:"H:[circle(circleSize)]",
//            options:[],
//            metrics:metrics,
//            views:views))
//        addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat:"V:[circle(circleSize)]",
//            options:[],
//            metrics:metrics,
//            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[gradient]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[gradient]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutCircleLeft = NSLayoutConstraint(
            item:circle,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        layoutCircleTop = NSLayoutConstraint(
            item:circle,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        gradient.mask = circle
        
        addConstraint(layoutCircleLeft)
        addConstraint(layoutCircleTop)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let cellWidth:CGFloat = bounds.maxX
        let cellHeight:CGFloat = bounds.maxY
        let remainWidth:CGFloat = cellWidth - kCircleSize
        let remainHeight:CGFloat = cellHeight - kCircleSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutCircleLeft.constant = marginLeft
        layoutCircleTop.constant = marginTop
        
        super.layoutSubviews()
    }
}
