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
            
            let usedSpaceInt:Int = controller.diskUsed,
            let totalSpaceInt:Int = MSession.sharedInstance.server?.froobSpace
            
            else
        {
            labelUsedSpace.text = kEmpty
            labelTotalSpace.text = kEmpty
            
            return
        }
        
        let usedSpace:NSNumber = (CGFloat(usedSpaceInt) / kKilobytesPerMega) as NSNumber
        let totalSpace:NSNumber = (CGFloat(totalSpaceInt) / kKilobytesPerMega) as NSNumber
        let usedSpaceString:String? = numberFormatter.string(from:usedSpace)
        let totalSpaceString:String? =  numberFormatter.string(from:totalSpace)
        labelUsedSpace.text = usedSpaceString
        labelTotalSpace.text = totalSpaceString
    }
    
    /*
    override func config(controller:CHome, model:MHomeItem)
    {
        guard
            
            let usedSpaceInt:Int = controller.diskUsed,
            let totalSpaceInt:Int = MSession.sharedInstance.server?.froobSpace
            
            else
        {
            labelUsedSpace.text = kEmpty
            labelTotalSpace.text = kEmpty
            
            return
        }
        
        let usedSpace:NSNumber = (CGFloat(usedSpaceInt) / kKilobytesPerMega) as NSNumber
        let totalSpace:NSNumber = (CGFloat(totalSpaceInt) / kKilobytesPerMega) as NSNumber
        let usedSpaceString:String? = numberFormatter.string(from:usedSpace)
        let totalSpaceString:String? =  numberFormatter.string(from:totalSpace)
        labelUsedSpace.text = usedSpaceString
        labelTotalSpace.text = totalSpaceString
    }*/
}
