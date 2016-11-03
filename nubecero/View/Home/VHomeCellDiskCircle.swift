import UIKit

class VHomeCellDiskCircle:UIView
{
    private let kLineWidth:CGFloat = 25
    private let kCircleRadius:CGFloat = 80
    private let kCircleStartAngle:CGFloat = 0
    private let circleEndAngle:CGFloat
    private let rectWidth:CGFloat
    private let rectHeight:CGFloat
    private let centerX:CGFloat
    private let centerY:CGFloat
    private let centerPoint:CGPoint
    
    override init(frame:CGRect)
    {
        rectWidth = frame.maxX
        rectHeight = frame.maxY
        centerX = rectWidth / 2.0
        centerY = rectHeight / 2.0
        centerPoint = CGPoint(x:centerX, y:centerY)
        circleEndAngle = 2.5
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        context.setLineWidth(kLineWidth)
        context.setLineCap(CGLineCap.round)
        context.addArc(
            center:centerPoint,
            radius:kCircleRadius,
            startAngle:kCircleStartAngle,
            endAngle:circleEndAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
}
