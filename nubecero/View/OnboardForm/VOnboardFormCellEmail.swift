import UIKit

class VOnboardFormCellEmail:VOnboardFormCell, UITextFieldDelegate
{
    private weak var textField:UITextField!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let textField:UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = UITextBorderStyle.none
        textField.font = UIFont.medium(size:15)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.next
        textField.keyboardAppearance = UIKeyboardAppearance.light
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = NSLocalizedString("VOnboardFormCellEmail_placeholder", comment:"")
        self.textField = textField
        
        addSubview(textField)
        
        let views:[String:UIView] = [
            "textField":textField]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-20-[textField]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
