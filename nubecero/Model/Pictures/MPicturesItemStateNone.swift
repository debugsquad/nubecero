import UIKit

class MPicturesItemStateNone:MPicturesItemState
{
    override func loadThumbnail() -> UIImage?
    {
        item?.startLoadingImage()
        
        return nil
    }
}
