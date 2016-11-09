import UIKit

class MOnboardFormItemEmail:MOnboardFormItem
{
    var email:String?
    private let kCellHeight:CGFloat = 40
    
    override init()
    {
        fatalError()
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
    
    init(email:String?)
    {
        let reusableIdentifier:String = VOnboardFormCellEmail.reusableIdentifier
        self.email = email
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
