import UIKit

class VHomeCellDisk:VHomeCell
{
    private weak var circle:VHomeCellDiskCircleMemory!
    private weak var circleBackground:VHomeCellDiskCircleBackground!
    private let circleSize:CGSize
    private let circleSide:CGFloat
    private let kCircleRadians:CGFloat = 6.28319
    
    override init(frame:CGRect)
    {
        let width:CGFloat = frame.size.width
        let height:CGFloat = frame.size.height
        circleSide = min(width, height)
        circleSize = CGSize(width:circleSide, height:circleSide)
        
        super.init(frame:frame)
        
        let circleFrame:CGRect = CGRect(
            origin:CGPoint(x:-circleSide, y:-circleSide),
            size:circleSize)
        
        let circle:VHomeCellDiskCircleMemory = VHomeCellDiskCircleMemory(frame:circleFrame)
        self.circle = circle
        let circleBackground:VHomeCellDiskCircleBackground = VHomeCellDiskCircleBackground(frame:circleFrame)
        self.circleBackground = circleBackground
        
        let gradient:VHomeCellDiskGradient = VHomeCellDiskGradient()
        gradient.mask = circle
        addSubview(circleBackground)
        addSubview(gradient)
        
        let views:[String:UIView] = [
            "gradient":gradient]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[gradient]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[gradient]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let cellWidth:CGFloat = bounds.maxX
        let cellHeight:CGFloat = bounds.maxY
        let remainWidth:CGFloat = cellWidth - circleSide
        let remainHeight:CGFloat = cellHeight - circleSide
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        let marginPoint:CGPoint = CGPoint(x:marginLeft, y:marginTop)
        let circleRect:CGRect = CGRect(origin:marginPoint, size:circleSize)
        circle.frame = circleRect
        circleBackground.frame = circleRect
        
        super.layoutSubviews()
    }
    
    override func config(controller:CHome, model:MHomeItem)
    {
        guard
            
            let diskUsed:Int = controller.diskUsed,
            let froobSpace:Int = MSession.sharedInstance.server?.froobSpace
            
        else
        {
            return
        }
        
        let froobSpaceFloat:CGFloat = CGFloat(froobSpace)
        let diskUsedFloat:CGFloat = CGFloat(diskUsed)
        var ratioDisk:CGFloat = diskUsedFloat / froobSpaceFloat
        
        if ratioDisk > 1
        {
            ratioDisk = 1
        }
        else if ratioDisk < 0
        {
            ratioDisk = 0
        }
        
        let percentDisk:CGFloat = ratioDisk * kCircleRadians
        circle.maxRadius(maxCircleEndAngle:percentDisk)
    }
}
