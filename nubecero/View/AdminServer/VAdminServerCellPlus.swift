import UIKit

class VAdminServerCellPlus:VAdminServerCell, UITextFieldDelegate
{
    private weak var textField:UITextField!
    private weak var modelPlus:MAdminServerItemPlus?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.font = UIFont.bold(size:13)
        label.textColor = UIColor(white:0.75, alpha:1)
        label.text = NSLocalizedString("VAdminServerCellPlus_labelTitle", comment:"")
        
        let textField:UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = UITextBorderStyle.none
        textField.font = UIFont.medium(size:19)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.done
        textField.keyboardAppearance = UIKeyboardAppearance.light
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.clearButtonMode = UITextFieldViewMode.never
        textField.keyboardType = UIKeyboardType.numbersAndPunctuation
        textField.placeholder = NSLocalizedString("VAdminServerCellPlus_placeholder", comment:"")
        self.textField = textField
        
        addSubview(label)
        addSubview(textField)
        
        let views:[String:UIView] = [
            "label":label,
            "textField":textField]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label(90)]-0-[textField]-5-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MAdminServerItem)
    {
        modelPlus = model as? MAdminServerItemPlus
        print()
    }
    
    //MARK: private
    
    private func print()
    {
        guard
            
            let space:Int = modelPlus?.space
            
        else
        {
            return
        }
        
        textField.text = "\(space)"
    }
    
    //MARK: textField delegate
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        guard
            
            let editedText:String = textField.text,
            let amountInt:Int = Int(editedText)
            
        else
        {
            print()
            
            return
        }
        
        modelPlus?.newSpace(space:amountInt)
        print()
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}
