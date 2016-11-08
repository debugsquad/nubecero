import UIKit

class VLoginCellEmail:VLoginCell, UITextFieldDelegate
{
    private weak var textField:UITextField!
    private weak var layoutFieldTop:NSLayoutConstraint!
    private weak var layoutFieldLeft:NSLayoutConstraint!
    private let kCornerRadius:CGFloat = 6
    private let kFieldWidth:CGFloat = 190
    private let kFieldHeight:CGFloat = 40
    private let kFieldMargin:CGFloat = 6
    
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
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = NSLocalizedString("VLoginCellEmail_placeholder", comment:"")
        self.textField = textField
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = UIColor.white
        baseView.clipsToBounds = true
        baseView.layer.cornerRadius = kCornerRadius
        
        baseView.addSubview(textField)
        addSubview(baseView)
        
        let views:[String:UIView] = [
            "textField":textField,
            "baseView":baseView]
        
        let metrics:[String:CGFloat] = [
            "fieldWidth":kFieldWidth,
            "fieldHeight":kFieldHeight,
            "fieldMargin":kFieldMargin]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(fieldMargin)-[textField]-(fieldMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[baseView(fieldWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[baseView(fieldHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutFieldLeft = NSLayoutConstraint(
            item:baseView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        layoutFieldTop = NSLayoutConstraint(
            item:baseView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutFieldLeft)
        addConstraint(layoutFieldTop)
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
    
    override func config(controller:CLogin, model:MLoginItem)
    {
        super.config(controller:controller, model:model)
        
        textField.text = controller.model.email
    }
    
    //MARK: field delegate
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        let email:String? = textField.text
        controller?.model.email = email
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}
