import UIKit

class MOnboardFormItem
{
    let reusableIdentifier:String
    let cellHeight:CGFloat
    
    init()
    {
        fatalError()
    }
    
    init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        self.reusableIdentifier = reusableIdentifier
        self.cellHeight = cellHeight
    }
}
