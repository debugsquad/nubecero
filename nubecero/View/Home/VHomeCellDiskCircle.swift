import UIKit

class VHomeCellDiskCircle:UIView
{
    private weak var timer:Timer?
    private var circleEndAngle:CGFloat
    private var maxCircleEndAngle:CGFloat
    private let rectWidth:CGFloat
    private let rectHeight:CGFloat
    private let centerX:CGFloat
    private let centerY:CGFloat
    private let centerPoint:CGPoint
    private let arrowRadius_2:CGFloat
    private let arrowSize:CGSize
    private let colorMain:CGColor
    private let colorBackground:CGColor
    private let kTimeInterval:TimeInterval = 0.03
    private let kAngleDelta:CGFloat = 0.14
    private let kLineWidth:CGFloat = 40
    private let kArrowRadius:CGFloat = 3
    private let kCircleRadius:CGFloat = 80
    private let kCircleStartAngle:CGFloat = 0
    private let kCircleBackgroundEndAngle:CGFloat = -0.00001
    private let kBackgroundAlpha:CGFloat = 0.2
    
    override init(frame:CGRect)
    {
        colorMain = UIColor.black.cgColor
        colorBackground = UIColor(white:1, alpha:kBackgroundAlpha).cgColor
        rectWidth = frame.size.width
        rectHeight = frame.size.height
        centerX = rectWidth / 2.0
        centerY = rectHeight / 2.0
        arrowRadius_2 = kArrowRadius / 2.0
        centerPoint = CGPoint(x:centerX, y:centerY)
        arrowSize = CGSize(width:kArrowRadius, height:kArrowRadius)
        circleEndAngle = kCircleStartAngle
        maxCircleEndAngle = kCircleStartAngle
        
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
        context.clear(CGRect(
            origin:CGPoint(
                x:arrowPoint.x - arrowRadius_2,
                y:arrowPoint.y - arrowRadius_2),
            size:arrowSize))
    }
    
    func tick(sender timer:Timer)
    {
        circleEndAngle += kAngleDelta
        
        if circleEndAngle > maxCircleEndAngle
        {
            circleEndAngle = maxCircleEndAngle
            timer.invalidate()
        }
        
        setNeedsDisplay()
    }
    
    //MARK: public
    
    func maxRadius(maxCircleEndAngle:CGFloat)
    {
        timer?.invalidate()
        
        self.maxCircleEndAngle = maxCircleEndAngle
        circleEndAngle = kCircleStartAngle
        timer = Timer.scheduledTimer(
            timeInterval:kTimeInterval,
            target:self,
            selector:#selector(tick(sender:)),
            userInfo:nil,
            repeats:true)
    }
}
