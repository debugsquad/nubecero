import UIKit

class VHomeCellDiskArrow:UIView
{
    var point:CGPoint?
    private let color:CGColor
    private let kArrowRadius:CGFloat = 3
    private let kArrowStartRadius:CGFloat = 0
    private let kArrowEndRadius:CGFloat = -0.00001
    
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
            radius:0kCircleRadius,
            startAngle:kCircleStartAngle,
            endAngle:circleEndAngle,
            clockwise:false)
        let arrowPoint:CGPoint = context.currentPointOfPath
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
}
