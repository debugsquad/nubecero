import UIKit

class VHomeCellBlank:VHomeCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
