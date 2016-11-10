import UIKit

class MOnboardFormItemPassGenerator:MOnboardFormItem
{
    private let kCellHeight:CGFloat = 40
    
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
