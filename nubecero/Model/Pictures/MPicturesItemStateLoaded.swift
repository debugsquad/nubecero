import UIKit

class MPicturesItemStateLoaded:MPicturesItemState
{
    override func loadThumbnail() -> UIImage?
    {
        guard
            
            let cgImage:CGImage = item?.thumbnail?.cgImage,
            let orientationInt:Int = item?.orientation
        
        else
        {
            return nil
        }
        
        let imageOrientation:UIImageOrientation = UIImageOrientation(rawValue:orientationInt)!
        let normalImage:UIImage = UIImage(
            cgImage:cgImage,
            scale:0,
            orientation:imageOrientation)
        
        return normalImage
    }
}
