import UIKit

class MPicturesItemStateNone:MPicturesItemState
{
    override func loadThumbnail() -> UIImage?
    {
        item?.stateLoading()
        
        return nil
    }
}
