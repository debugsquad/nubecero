import UIKit

class VHomeCellDiskArrow:UIView
{
    var point:CGPoint?
    private let color:CGColor
    private let kRadius:CGFloat = 3
    private let kStartAngle:CGFloat = 0
    private let kEndAngle:CGFloat = -0.00001
    
    override init(frame:CGRect)
    {
        color = UIColor.black.cgColor
        
        super.init(frame:frame)
        clipsToBounds = true
        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext(),
            let point:CGPoint = point
        
        else
        {
            return
        }
        
        context.setFillColor(color)
        context.addArc(
            center:point,
            radius:kRadius,
            startAngle:kStartAngle,
            endAngle:kEndAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.fill)
    }
}
