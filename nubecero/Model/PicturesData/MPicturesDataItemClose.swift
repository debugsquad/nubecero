import UIKit

class MPicturesDataItemClose:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 120
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellClose.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
