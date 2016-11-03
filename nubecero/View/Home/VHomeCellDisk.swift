import UIKit

class VHomeCellDisk:VHomeCell
{
    weak var circle:VHomeCellDiskCircle!
    private let circleSize:CGSize
    private let circleSide:CGFloat
    
    override init(frame:CGRect)
    {
        let width:CGFloat = frame.size.width
        let height:CGFloat = frame.size.height
        circleSide = min(width, height)
        circleSize = CGSize(width:circleSide, height:circleSide)
        
        super.init(frame:frame)
        
        let circleFrame:CGRect = CGRect(
            origin:CGPoint(x:-circleSide, y:-circleSide),
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
        let remainWidth:CGFloat = cellWidth - circleSide
        let remainHeight:CGFloat = cellHeight - circleSide
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        let marginPoint:CGPoint = CGPoint(x:marginLeft, y:marginTop)
        let circleRect:CGRect = CGRect(origin:marginPoint, size:circleSize)
        circle.frame = circleRect
        
        super.layoutSubviews()
    }
    
    override func config(controller:CHome, model:MHomeItem)
    {
        guard
        
            let modelDisk:MHomeItemDisk = model as? MHomeItemDisk
        
        else
        {
            return
        }
    }
}
