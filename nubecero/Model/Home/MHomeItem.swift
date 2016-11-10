import UIKit

class MHomeItem
{
    let reusableIdentifier:String
    let cellHeight:CGFloat
    let selectable:Bool
    
    init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        self.reusableIdentifier = reusableIdentifier
        self.cellHeight = cellHeight
        self.selectable = selectable
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected(controller:CHome)
    {
    }
}
