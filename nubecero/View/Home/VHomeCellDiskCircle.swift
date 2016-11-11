import UIKit

class VHomeCellDiskCircle:UIView
{
    var circleEndAngle:CGFloat
    let kCircleStartAngle:CGFloat = -CGFloat(M_PI)
    private let rectWidth:CGFloat
    private let rectHeight:CGFloat
    private let centerX:CGFloat
    private let centerY:CGFloat
    private let centerPoint:CGPoint
    private let arrowRadius_2:CGFloat
    private let arrowSize:CGSize
    private let color:CGColor
    private let kLineWidth:CGFloat = 22
    private let kArrowRadius:CGFloat = 3
    private let kCircleRadius:CGFloat = 40
    private let showArrow:Bool
    
    init(frame:CGRect, color:UIColor, showArrow:Bool)
    {
        rectWidth = frame.size.width
        rectHeight = frame.size.height
        centerX = rectWidth / 2.0
        centerY = rectHeight / 2.0
        arrowRadius_2 = kArrowRadius / 2.0
        centerPoint = CGPoint(x:centerX, y:centerY)
        arrowSize = CGSize(width:kArrowRadius, height:kArrowRadius)
        circleEndAngle = kCircleStartAngle
        self.color = color.cgColor
        self.showArrow = showArrow
        
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
        context.setStrokeColor(color)
        context.addArc(
            center:centerPoint,
            radius:kCircleRadius,
            startAngle:kCircleStartAngle,
            endAngle:circleEndAngle,
            clockwise:false)
        let arrowPoint:CGPoint = context.currentPointOfPath
        context.drawPath(using:CGPathDrawingMode.stroke)
        
        if showArrow
        {
            context.clear(CGRect(
                origin:CGPoint(
                    x:arrowPoint.x - arrowRadius_2,
                    y:arrowPoint.y - arrowRadius_2),
                size:arrowSize))
        }
    }
}
