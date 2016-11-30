import UIKit

class MHomeItemSpacePhotos:MHomeItem
{
    private let kCellHeight:CGFloat = 44
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VHomeCellPhotos.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
}
