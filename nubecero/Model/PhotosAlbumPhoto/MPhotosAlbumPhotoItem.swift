import UIKit

class MPhotosAlbumPhotoItem
{
    let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected(controller:CPhotosAlbumPhoto)
    {
        
    }
}
