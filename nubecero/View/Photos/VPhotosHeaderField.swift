import UIKit

class VPhotosHeaderField:UIView, UITextFieldDelegate
{
    weak var controller:CPhotos?
    weak var textField:UITextField!
    private let kCornerRadius:CGFloat = 10
    private let kMarginHorizontal:CGFloat = 10
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor(white:0, alpha:0.3).cgColor
        
        let textField:UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = UITextBorderStyle.none
        textField.font = UIFont.medium(size:18)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.done
        textField.keyboardAppearance = UIKeyboardAppearance.light
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.clearButtonMode = UITextFieldViewMode.never
        textField.keyboardType = UIKeyboardType.alphabet
        textField.placeholder = NSLocalizedString("VPhotosHeaderField_placeholder", comment:"")
        self.textField = textField
        
        addSubview(textField)
        
        let views:[String:UIView] = [
            "textField":textField]
        
        let metrics:[String:CGFloat] = [
            "marginHorizontal":kMarginHorizontal]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(marginHorizontal)-[textField]-2-|",
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
    
    //MARK: textfield delegate
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return false
    }
}
