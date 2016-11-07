import UIKit

class MLoginItemVoid:MLoginItem
{
    private let kCellHeight:CGFloat = 20
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VLoginCellVoid.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
