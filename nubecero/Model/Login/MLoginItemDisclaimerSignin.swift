import UIKit

class MLoginItemDisclaimerSignin:MLoginItem
{
    private let kCellHeight:CGFloat = 70
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VLoginCellDisclaimerSignin.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}