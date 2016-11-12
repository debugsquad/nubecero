import UIKit

class MOnboardFormItemForgot:MOnboardFormItem
{
    private let kCellHeight:CGFloat = 50
    
    override init()
    {
        let reusableIdentifier:String = VOnboardFormCellForgot.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
