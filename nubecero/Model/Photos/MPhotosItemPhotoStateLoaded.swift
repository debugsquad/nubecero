import UIKit

class MPhotosItemPhotoStateLoaded:MPhotosItemPhotoState
{
    override func loadThumbnail() -> UIImage?
    {
        return item?.thumbnail
    }
    
    override func loadImage() -> UIImage?
    {
        item?.becameActive()
        
        if item?.image == nil
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                { [weak self] in
                    
                    self?.item?.loadImageData()
            }
        }
        
        return item?.image
    }
}
