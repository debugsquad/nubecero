import UIKit

class MAdminServerItemFroob:MAdminServerItem
{
    var space:Int
    private let kCellHeight:CGFloat = 70
    private let kSelectable:Bool = false
    
    init(space:Int)
    {
        self.space = space
        
        let reusableIdentifier:String = VAdminServerCell.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override init()
    {
        fatalError()
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
}
