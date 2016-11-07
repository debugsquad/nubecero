import UIKit

class MLoginItemMode:MLoginItem
{
    private let kCellHeight:CGFloat = 100
    private let kSelectable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VLoginCellMode.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
