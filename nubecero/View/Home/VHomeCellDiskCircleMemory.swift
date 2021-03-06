import UIKit

class VHomeCellDiskCircleMemory:VHomeCellDiskCircle
{
    private weak var timer:Timer?
    private var maxCircleEndAngle:CGFloat
    private let kTimeInterval:TimeInterval = 0.01
    private let kAngleDelta:CGFloat = 0.06
    
    override init(frame:CGRect)
    {
        maxCircleEndAngle = 0
        
        super.init(frame:frame, color:UIColor.black)
    }
    
    override init(frame:CGRect, color:UIColor)
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
        
        self.maxCircleEndAngle = maxCircleEndAngle + kCircleStartAngle
        circleEndAngle = kCircleStartAngle
        timer = Timer.scheduledTimer(
            timeInterval:kTimeInterval,
            target:self,
            selector:#selector(tick(sender:)),
            userInfo:nil,
            repeats:true)
    }
}
