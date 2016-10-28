import UIKit

class MHomeItemUpload:MHomeItem
{
    private let kCellHeight:CGFloat = 100
    private let kSelectable:Bool = true
    
    init()
    {
        let reusableIdentifier:String = VHomeCellUpload.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override func selected(controller:CHome)
    {
        
    }
}
