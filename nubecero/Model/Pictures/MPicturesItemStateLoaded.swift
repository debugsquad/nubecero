import UIKit

class MPicturesItemStateLoaded:MPicturesItemState
{
    override func loadThumbnail() -> UIImage?
    {
        return item?.thumbnail
    }
}
