import UIKit

class VSettingsCellBlank:VSettingsCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        isHidden = true
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
