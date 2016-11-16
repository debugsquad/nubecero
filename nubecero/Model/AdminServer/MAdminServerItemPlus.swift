import UIKit

class MAdminServerItemPlus:MAdminServerItem
{
    private(set) var space:Int
    private let kCellHeight:CGFloat = 65
    private let kSelectable:Bool = false
    private let kServerMinimumPlusSize:Int = 500000
    
    init(space:Int)
    {
        self.space = space
        
        let reusableIdentifier:String = VAdminServerCellPlus.reusableIdentifier
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
    
    //MARK: private
    
    func newSpace(space:Int)
    {
        if space >= kServerMinimumPlusSize
        {
            self.space = space
        }
        else
        {
            self.space = kServerMinimumPlusSize
        }
    }
}
