import UIKit

class MOnboardFormItemRemember:MOnboardFormItem
{
    private let kCellHeight:CGFloat = 50
    
    override init()
    {
        let reusableIdentifier:String = VOnboardFormCellRemember.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
