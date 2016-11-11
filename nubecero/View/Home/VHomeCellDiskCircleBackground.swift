import UIKit

class VHomeCellDiskCircleBackground:VHomeCellDiskCircle
{
    private let kCircleEndAngle:CGFloat = -0.00001
    private let kAlphaColor:CGFloat = 0.1
    private let kShowArrow:Bool = false
    
    init(frame:CGRect)
    {
        super.init(frame:frame, color:UIColor(white:0, alpha:kAlphaColor), showArrow:kShowArrow)
        circleEndAngle = kCircleStartAngle + kCircleEndAngle
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
