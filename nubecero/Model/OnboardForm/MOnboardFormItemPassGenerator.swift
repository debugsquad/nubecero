import UIKit

class MOnboardFormItemPassGenerator:MOnboardFormItem
{
    private let kCellHeight:CGFloat = 42
    
    override init()
    {
        let reusableIdentifier:String = VOnboardFormCellPassGenerator.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
