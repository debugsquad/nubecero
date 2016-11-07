import UIKit

class MLoginItemEmail:MLoginItem
{
    private let kCellHeight:CGFloat = 70
    private let kSelectable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VLoginCellEmail.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
