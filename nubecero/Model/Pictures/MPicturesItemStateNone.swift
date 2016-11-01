import UIKit

class MPicturesItemStateNone:MPicturesItemState
{
    override func loadThumbnail() -> UIImage?
    {
        item?.state = MPicturesItemStateLoading(item:item)
        
        return nil
    }
}
