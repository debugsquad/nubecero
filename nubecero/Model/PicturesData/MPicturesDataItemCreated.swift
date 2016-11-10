import UIKit

class MPicturesDataItemCreated:MPicturesDataItem
{
    private let kCellHeight:CGFloat = 100
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDataCellCreated.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
