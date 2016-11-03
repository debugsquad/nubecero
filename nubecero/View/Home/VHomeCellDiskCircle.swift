import UIKit

class VHomeCellDiskCircle:UIView
{
    private let circleEndAngle:CGFloat
    private let rectWidth:CGFloat
    private let rectHeight:CGFloat
    private let centerX:CGFloat
    private let centerY:CGFloat
    private let centerPoint:CGPoint
    private let colorMain:CGColor
    private let colorBackground:CGColor
    private let colorArrow:CGColor
    private let kLineWidth:CGFloat = 40
    private let kArrowRadius:CGFloat = 6
    private let kCircleRadius:CGFloat = 80
    private let kCircleStartAngle:CGFloat = 0
    private let kCircleBackgroundEndAngle:CGFloat = -0.00001
    private let kBackgroundAlpha:CGFloat = 0.2
    
    override init(frame:CGRect)
    {
        colorMain = UIColor.black.cgColor
        colorBackground = UIColor(white:1, alpha:kBackgroundAlpha).cgColor
        colorArrow = UIColor.complement.cgColor
        rectWidth = frame.size.width
        rectHeight = frame.size.height
        centerX = rectWidth / 2.0
        centerY = rectHeight / 2.0
        centerPoint = CGPoint(x:centerX, y:centerY)
        circleEndAngle = 4.2
        
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
        context.setFillColor(colorArrow)
        context.setStrokeColor(colorBackground)
        context.addArc(
            center:centerPoint,
            radius:kCircleRadius,
            startAngle:kCircleStartAngle,
            endAngle:kCircleBackgroundEndAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
        context.setStrokeColor(colorMain)
        context.addArc(
            center:centerPoint,
            radius:kCircleRadius,
            startAngle:kCircleStartAngle,
            endAngle:circleEndAngle,
            clockwise:false)
        let arrowPoint:CGPoint = context.currentPointOfPath
        context.drawPath(using:CGPathDrawingMode.stroke)
        context.addArc(
            center:arrowPoint,
            radius:kArrowRadius,
            startAngle:kCircleStartAngle,
            endAngle:kCircleBackgroundEndAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.fill)
    }
}
