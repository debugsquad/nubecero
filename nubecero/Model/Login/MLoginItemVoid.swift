import UIKit

class MLoginItemVoid:MLoginItem
{
    private let kCellHeight:CGFloat = 40
    private let kSelectable:Bool = false
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
    
    override init()
    {
        let reusableIdentifier:String = VLoginCellVoid.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
