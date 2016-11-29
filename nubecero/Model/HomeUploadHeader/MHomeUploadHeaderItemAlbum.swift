import UIKit

class MHomeUploadHeaderItemAlbum:MHomeUploadHeaderItem
{
    private let kEmpty:String = ""
    
    init(controller:CHomeUpload)
    {
        if let title:String = controller.album?.name
        {
            self.title = title
        }
        else
        {
            self.title = kEmpty
        }
        
        let color:UIColor = UIColor.complement
        
        super.init(
            image:#imageLiteral(resourceName: "assetHomeAlbum"),
            title:title,
            color:color)
    }
    
    override init()
    {
        fatalError()
    }
    
    override init(image:UIImage, title:String, color:UIColor)
    {
        fatalError()
    }
    
    override func selected(controller:CHomeUpload?)
    {
        controller?.changeAlbum()
    }
}
