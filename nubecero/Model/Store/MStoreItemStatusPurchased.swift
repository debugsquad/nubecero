import UIKit

class MStoreItemStatusPurchased:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 40
    
    override init()
    {
        let reusableIdentifier:String = VStoreCellPurchased.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
