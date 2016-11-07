import UIKit

class MLoginItemPassword:MLoginItem
{
    private let kCellHeight:CGFloat = 70
    private let kSelectable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VLoginCellPassword.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
