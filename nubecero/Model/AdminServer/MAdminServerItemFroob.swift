import UIKit

class MAdminServerItemFroob:MAdminServerItem
{
    private let kCellHeight:CGFloat = 70
    private let kSelectable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = ""
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
