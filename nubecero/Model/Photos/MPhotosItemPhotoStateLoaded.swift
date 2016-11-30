import UIKit

class MPhotosItemPhotoStateLoaded:MPhotosItemPhotoState
{
    override func loadThumbnail() -> UIImage?
    {
        return item?.resources.thumbnail
    }
    
    override func loadImage() -> UIImage?
    {
        var image:UIImage? = item?.resources.image
        
        item?.resources.becameActive()
        
        if image == nil
        {
            image = item?.resources.thumbnail
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.item?.resources.loadImageData()
            }
        }
        
        return image
    }
}
