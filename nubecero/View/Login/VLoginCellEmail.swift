import UIKit

class VLoginCellEmail:VLoginCell, UITextFieldDelegate
{
    private weak var textField:UITextField!
    private weak var layoutFieldTop:NSLayoutConstraint!
    private weak var layoutFieldLeft:NSLayoutConstraint!
    private let kFieldWidth:CGFloat = 120
    private let kFieldHeight:CGFloat = 36
    
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
        textField.clearButtonMode = UITextFieldViewMode.never
        textField.placeholder = NSLocalizedString("VLoginCellEmail_placeholder", comment:"")
        self.textField = textField
        
        addSubview(textField)
        
        let views:[String:UIView] = [
            "textField":textField]
        
        let metrics:[String:CGFloat] = [
            "fieldWidth":kFieldWidth,
            "fieldHeihgt":kFieldHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[textField(fieldWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[textField(fieldHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let maxWidth:CGFloat = bounds.maxX
        let maxHeight:CGFloat = bounds.maxY
        let remainWidth:CGFloat = maxWidth - kFieldWidth
        let remainHeight:CGFloat = maxHeight - kFieldHeight
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        
        layoutFieldLeft.constant = marginLeft
        layoutFieldTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: field delegate
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}
