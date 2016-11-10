import UIKit

class VOnboardFormCellPassword:VOnboardFormCell, UITextFieldDelegate
{
    private weak var textField:UITextField!
    private weak var model:MOnboardFormItemPassword?
    private weak var controller:COnboardForm?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:0, alpha:0.1)
        
        let textField:UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = UITextBorderStyle.none
        textField.font = UIFont.medium(size:15)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.send
        textField.keyboardAppearance = UIKeyboardAppearance.light
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.alphabet
        textField.isSecureTextEntry = true
        textField.placeholder = NSLocalizedString("VOnboardFormCellPassword_placeholder", comment:"")
        self.textField = textField
        
        addSubview(border)
        addSubview(textField)
        
        let views:[String:UIView] = [
            "textField":textField,
            "border":border]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-20-[textField]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MOnboardFormItem, controller:COnboardForm)
    {
        self.model = model as? MOnboardFormItemPassword
        self.controller = controller
        controller.passwordField = textField
        textField.text = self.model?.password
    }
    
    //MARK: textfield delegate
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        model?.password = textField.text
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        controller?.send()
        
        return true
    }
    
    func textField(_ textField:UITextField, shouldChangeCharactersIn range:NSRange, replacementString string:String) -> Bool
    {
        textField.isSecureTextEntry = true
        
        return true
    }
}
