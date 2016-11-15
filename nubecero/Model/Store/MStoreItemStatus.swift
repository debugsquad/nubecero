import UIKit

class MStoreItemStatus
{
    let reusableIdentifier:String
    let selectable:Bool
    let cellHeight:CGFloat
    
    init(reusableIdentifier:String, selectable:Bool, cellHeight:CGFloat)
    {
        self.reusableIdentifier = reusableIdentifier
        self.selectable = selectable
        self.cellHeight = cellHeight
    }
    
    init()
    {
        fatalError()
    }
}
