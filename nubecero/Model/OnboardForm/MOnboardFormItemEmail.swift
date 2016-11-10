import UIKit

class MOnboardFormItemEmail:MOnboardFormItem
{
    var email:String?
    private let kCellHeight:CGFloat = 44
    
    init(email:String?)
    {
        let reusableIdentifier:String = VOnboardFormCellEmail.reusableIdentifier
        self.email = email
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
