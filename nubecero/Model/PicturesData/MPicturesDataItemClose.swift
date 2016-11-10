import UIKit

class MPicturesDataItemClose:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 74
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellClose.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
