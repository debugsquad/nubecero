import UIKit

class VHomeCellDiskCircleMemory:VHomeCellDiskCircle
{
    private weak var timer:Timer?
    private var maxCircleEndAngle:CGFloat = 0
    private let kTimeInterval:TimeInterval = 0.015
    private let kAngleDelta:CGFloat = 0.09
    private let kShowArrow:Bool = true
    
    init(frame:CGRect)
    {
        super.init(frame:frame, color:UIColor.black, showArrow:kShowArrow)
        
        maxCircleEndAngle = kCircleStartAngle
    }
    
    override init(frame:CGRect, color:UIColor, showArrow:Bool)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
