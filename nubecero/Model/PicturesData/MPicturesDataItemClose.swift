import UIKit

class MPicturesDataItemClose:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 70
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellClose.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
