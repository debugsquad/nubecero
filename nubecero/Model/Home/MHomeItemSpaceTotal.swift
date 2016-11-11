import UIKit

class MHomeItemSpaceTotal:MHomeItem
{
    private let kCellHeight:CGFloat = 44
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VHomeCellSpaceTotal.reusableIdentifier
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
