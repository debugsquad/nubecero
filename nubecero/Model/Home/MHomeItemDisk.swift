import UIKit

class MHomeItemDisk:MHomeItem
{
    private let kCellHeight:CGFloat = 250
    private let kSelectable:Bool = false
    var percentUsed:CGFloat?
    
    override init()
    {
        let reusableIdentifier:String = VHomeCellDisk.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
