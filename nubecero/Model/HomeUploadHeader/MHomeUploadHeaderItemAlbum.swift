import UIKit

class MHomeUploadHeaderItemAlbum:MHomeUploadHeaderItem
{
    private let kEmpty:String = ""
    
    init(controller:CHomeUpload)
    {
        let albumTitle:String
        
        if let title:String = controller.album?.name
        {
            albumTitle = title
        }
        else
        {
            albumTitle = kEmpty
        }
        
        let color:UIColor = UIColor.complement
        
        super.init(
            image:#imageLiteral(resourceName: "assetHomeAlbum"),
            title:albumTitle,
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
