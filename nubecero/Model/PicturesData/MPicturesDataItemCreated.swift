import UIKit

class MPicturesDataItemCreated:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 80
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellCreated.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
