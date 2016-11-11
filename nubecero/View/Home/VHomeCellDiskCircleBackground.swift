import UIKit

class VHomeCellDiskCircleBackground:VHomeCellDiskCircle
{
    private let kCircleEndAngle:CGFloat = -0.00001
    private let kShowArrow:Bool = false
    
    init(frame:CGRect)
    {
        super.init(frame:frame, color:UIColor.complement, showArrow:kShowArrow)
        circleEndAngle = kCircleEndAngle
    }
    
    override init(frame:CGRect, color:UIColor, showArrow:Bool)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
