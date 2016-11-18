import UIKit

class MPhotosItemPhotoStateNone:MPhotosItemPhotoState
{
    override func loadThumbnail() -> UIImage?
    {
        item?.stateLoading()
        
        return nil
    }
}
