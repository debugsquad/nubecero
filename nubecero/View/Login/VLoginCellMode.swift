import UIKit

class VLoginCellMode:VLoginCell
{
    private weak var segmentedControl:UISegmentedControl!
    private weak var layoutSegmentedLeft:NSLayoutConstraint!
    private weak var controller:CLogin?
    private let kSegmentedWidth:CGFloat = 220
    private let kSegmentedHeight:CGFloat = 36
    private let kSegmentedTop:CGFloat = 2
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let modeNames:[String] = MLoginMode.ModeNames()
        
        let segmentedControl:UISegmentedControl = UISegmentedControl(
            items:modeNames)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.clipsToBounds = true
        segmentedControl.tintColor = UIColor.white
        
        addSubview(segmentedControl)
        
        let views:[String:UIView] = [
            "segmentedControl":segmentedControl]
        
        let metrics:[String:CGFloat] = [
            "segmentedWidth":kSegmentedWidth,
            "segmentedHeight":kSegmentedHeight,
            "segmentedTop":kSegmentedTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[segmentedControl(segmentedWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(segmentedTop)-[segmentedControl(segmentedHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutSegmentedLeft = NSLayoutConstraint(
            item:segmentedControl,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutSegmentedLeft)
    }
    
    override func layoutSubviews()
    {
        let maxWidth:CGFloat = bounds.maxX
        let remain:CGFloat = maxWidth - kSegmentedWidth
        let margin:CGFloat = remain / 2.0
        layoutSegmentedLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CLogin, model:MLoginItem)
    {
        self.controller = controller
        
        
    }
    
    //MARK: actions
    
    func actionChangeMode(sender segmented:UISegmentedControl)
    {
        
    }
}
