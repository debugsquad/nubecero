import UIKit

class MPicturesDataItemClose:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 76
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellClose.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
