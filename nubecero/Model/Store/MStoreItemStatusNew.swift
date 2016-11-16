import UIKit

class MStoreItemStatusNew:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 30
    
    override init()
    {
        let reusableIdentifier:String = VStoreCellNew.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
