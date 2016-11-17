import UIKit

class MStoreItemStatusNotAvailable:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 40
    private let kRestorable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VStoreCellNotAvailable.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            restorable:kRestorable)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
