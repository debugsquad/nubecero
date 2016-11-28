import UIKit

class MHomeUploadHeaderItemSelectAll:MHomeUploadHeaderItem
{
    override init()
    {
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
        controller?.selectAll()
    }
}
