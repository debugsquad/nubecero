import UIKit

class MHomeItemPictures:MHomeItem
{
    private let kCellHeight:CGFloat = 40
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VHomeCellPictures.reusableIdentifier
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
