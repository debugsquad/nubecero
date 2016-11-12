import UIKit

class VHomeCellBlank:VHomeCell
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
