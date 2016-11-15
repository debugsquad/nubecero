import UIKit

class MStoreItemStatusPurchasing:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 30
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = ""
        super.init(
            reusableIdentifier:reusableIdentifier,
            selectable:kSelectable,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, selectable:Bool, cellHeight:CGFloat)
    {
        fatalError()
    }
}
