import UIKit

class MLoginItemSend:MLoginItem
{
    private let kCellHeight:CGFloat = 60
    private let kSelectable:Bool = true
    
    override init()
    {
        let reusableIdentifier:String = VLoginCellSend.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
