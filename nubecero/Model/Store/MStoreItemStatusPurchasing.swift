import UIKit

class MStoreItemStatusPurchasing:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 30
    
    override init()
    {
        let reusableIdentifier:String = VStoreCellPurchasing.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
