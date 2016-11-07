import UIKit

class VLoginCellDisclaimerSignin:VLoginCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.font = UIFont.regular(size:15)
        label.text = NSLocalizedString("VLoginCellDisclaimerSignin_label", comment:"")
        
        addSubview(label)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
