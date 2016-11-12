import UIKit

class VHomeCellDiskCircleBackground:VHomeCellDiskCircle
{
    private let kCircleEndAngle:CGFloat = -0.00001
    private let kAlphaColor:CGFloat = 0.1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame, color:UIColor(white:0, alpha:kAlphaColor))
        circleEndAngle = kCircleStartAngle + kCircleEndAngle
    }
    
    override init(frame:CGRect, color:UIColor)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
