import UIKit

class VHomeCellDiskCircle:UIView
{
    private let kLineWidth:CGFloat = 25
    private let kCircleRadius:CGFloat = 80
    private let kCircleStartAngle:CGFloat = 0
    private let strokeColor:CGColor
    
    init()
    {
        strokeColor = UIColor.red.cgColor
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
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
        
        let rectWidth:CGFloat = rect.maxX
        let rectHeight:CGFloat = rect.maxY
        let centerX:CGFloat = rectWidth / 2.0
        let centerY:CGFloat = rectHeight / 2.0
        let centerPoint:CGPoint = CGPoint(x:centerX, y:centerY)
        
        context.setLineWidth(kLineWidth)
        context.setLineCap(CGLineCap.round)
        context.setStrokeColor(strokeColor)
        context.addArc(
            center:centerPoint,
            radius:kCircleRadius,
            startAngle:kCircleStartAngle,
            endAngle:2,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
}
