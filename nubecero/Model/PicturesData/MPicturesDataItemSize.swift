import UIKit

class MPicturesDataItemSize:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 90
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellSize.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
