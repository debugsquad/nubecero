import UIKit

class MPicturesDataItemSize:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 200
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellSize.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
