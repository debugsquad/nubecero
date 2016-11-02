import UIKit

class MPicturesDataItemSize:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 150
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellSize.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
