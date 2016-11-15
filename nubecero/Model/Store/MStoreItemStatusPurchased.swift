import UIKit

class MStoreItemStatusPurchased:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 30
    
    override init()
    {
        let reusableIdentifier:String = ""
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, selectable:Bool, cellHeight:CGFloat)
    {
        fatalError()
    }
}
