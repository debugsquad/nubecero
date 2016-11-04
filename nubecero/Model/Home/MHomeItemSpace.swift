import UIKit

class MHomeItemSpace:MHomeItem
{
    private let kCellHeight:CGFloat = 120
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VHomeCellSpace.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
