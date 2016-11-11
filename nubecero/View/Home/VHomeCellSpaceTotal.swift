import UIKit

class VHomeCellSpaceTotal:VHomeCellSpace
{
    override init(frame:CGRect)
    {
        let color:UIColor = UIColor.complement
        
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
        let totalStorageInt:Int = MSession.sharedInstance.totalStorage()
        let totalSpace:NSNumber = (CGFloat(totalStorageInt) / kKilobytesPerMega) as NSNumber
        
        guard
            
            let totalSpaceString:String = numberFormatter.string(from:totalSpace)
            
        else
        {
            label.text = kEmpty
            
            return
        }
        
        let compountString:String = String(
            format:NSLocalizedString("VHomeCellSpaceTotal_label", comment:""),
            totalSpaceString)
        label.text = compountString
    }
}
