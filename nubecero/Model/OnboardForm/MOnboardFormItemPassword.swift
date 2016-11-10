import UIKit

class MOnboardFormItemPassword:MOnboardFormItem
{
    var password:String?
    private let kCellHeight:CGFloat = 44
    
    init(password:String?)
    {
        let reusableIdentifier:String = VOnboardFormCellPassword.reusableIdentifier
        self.password = password
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init()
    {
        fatalError()
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
