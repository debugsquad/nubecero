import UIKit

class MLoginItemDisclaimerSignup:MLoginItem
{
    private let kCellHeight:CGFloat = 50
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VLoginCellDisclaimerSignup.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
