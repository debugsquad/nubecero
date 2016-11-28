import UIKit

class MHomeUploadHeaderItemSelectAll:MHomeUploadHeaderItem
{
    private var selected:Bool
    
    override init()
    {
        selected = false
        let title:String = NSLocalizedString("MHomeUploadHeaderItemSelectAll_title", comment:"")
        let color:UIColor = UIColor.main
        
        super.init(
            image:#imageLiteral(resourceName: "assetHomeSelectAll"),
            title:title,
            color:color)
    }
    
    override init(image:UIImage, title:String, color:UIColor)
    {
        fatalError()
    }
    
    override func selected(controller:CHomeUpload?)
    {
        selected = !selected
        controller?.selectAll(selection:selected)
    }
}
