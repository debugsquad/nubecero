import UIKit

class MHomeItemUpload:MHomeItem
{
    private let kCellHeight:CGFloat = 102
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VHomeCellUpload.reusableIdentifier
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
