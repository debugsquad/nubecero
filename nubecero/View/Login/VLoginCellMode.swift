import UIKit

class VLoginCellMode:VLoginCell
{
    private weak var segmentedControl:UISegmentedControl!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let itemsSegmented
        
        let segmentedControl:UISegmentedControl = UISegmentedControl(
            items:nil)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.clipsToBounds = true
        segmentedControl.setite
        
        addSubview(segmentedControl)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
