import UIKit

class MPhotosItemPhotoStateLoaded:MPhotosItemPhotoState
{
    override func loadThumbnail() -> UIImage?
    {
        return item?.resources.thumbnail
    }
    
    override func loadImage() -> UIImage?
    {
        item?.resources.becameActive()
        
        if item?.resources.image == nil
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.item?.resources.loadImageData()
            }
        }
        
        return item?.resources.image
    }
}
