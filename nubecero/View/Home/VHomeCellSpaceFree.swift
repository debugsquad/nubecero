import UIKit

class VHomeCellSpaceFree:VHomeCellSpace
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
        
        let totalStorageInt:Int = MSession.sharedInstance.server.totalStorage()
        var freeSpaceInt:Int = totalStorageInt - usedSpaceInt
        
        if freeSpaceInt < 0
        {
            freeSpaceInt = 0
        }
        
        let freeSpace:NSNumber = (CGFloat(freeSpaceInt) / kKilobytesPerMega) as NSNumber
        
        guard
            
            let freeSpaceString:String = numberFormatter.string(from:freeSpace)
        
        else
        {
            label.text = kEmpty
            
            return
        }
        
        let compountString:String = String(
            format:NSLocalizedString("VHomeCellSpaceFree_label", comment:""),
            freeSpaceString)
        label.text = compountString
    }
}
