import UIKit

class MPicturesItemStateLoaded:MPicturesItemState
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
            item?.loadImageData()
        }
        
        return item?.image
    }
}
