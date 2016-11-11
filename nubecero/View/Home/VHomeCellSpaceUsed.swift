import UIKit

class VHomeCellSpaceUsed:VHomeCellSpace
{
    override init(frame:CGRect)
    {
        let color:UIColor = UIColor(white:0, alpha:0.1)
        
        super.init(frame:frame, color:color)
    }
    
    override init(frame:CGRect, color:UIColor)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CHome, model:MHomeItem)
    {
        guard
            
            let usedSpaceInt:Int = controller.diskUsed
            
        else
        {
            label.text = kEmpty
            
            return
        }
        
        let usedSpace:NSNumber = (CGFloat(usedSpaceInt) / kKilobytesPerMega) as NSNumber
        
        guard
            
            let usedSpaceString:String = numberFormatter.string(from:usedSpace)
            
        else
        {
            label.text = kEmpty
            
            return
        }
        
        let compountString:String = String(
            format:NSLocalizedString("VHomeCellSpaceUsed_label", comment:""),
            usedSpaceString)
        label.text = compountString
    }
}
