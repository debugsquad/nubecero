import UIKit

class MOnboardFormItemEmail:MOnboardFormItem
{
    let email:String?
    private let kCellHeight:CGFloat = 34
    
    init(email:String?)
    {
        let reusableIdentifier:String = VOnboardFormCellEmail.reusableIdentifier
        self.email = email
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
