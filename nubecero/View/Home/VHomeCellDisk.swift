import UIKit

class VHomeCellDisk:VHomeCell
{
    private weak var circle:VHomeCellDiskCircle!
    private let circleSize:CGSize
    private let kCircleSize:CGFloat = 240
    
    override init(frame:CGRect)
    {
        circleSize = CGSize(width:kCircleSize, height:kCircleSize)
        
        super.init(frame:frame)
        
        let circleFrame:CGRect = CGRect(
            origin:CGPoint(x:-kCircleSize, y:-kCircleSize),
            size:circleSize)
        let circle:VHomeCellDiskCircle = VHomeCellDiskCircle(frame:circleFrame)
        self.circle = circle
        
        let gradient:VHomeCellDiskGradient = VHomeCellDiskGradient()
        gradient.mask = circle
        addSubview(gradient)
        
        let views:[String:UIView] = [
            "circle":circle,
            "gradient":gradient]
        
        let metrics:[String:CGFloat] = [:]
        
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
        let marginPoint:CGPoint = CGPoint(x:marginLeft, y:marginTop)
        let circleRect:CGRect = CGRect(origin:marginPoint, size:circleSize)
        circle.frame = circleRect
        
        super.layoutSubviews()
    }
}
