import UIKit

class MPhotosItemPhotoState
{
    weak var item:MPhotosItemPhoto?
    
    init(item:MPhotosItemPhoto?)
    {
        self.item = item
        preparations()
    }
    
    //MARK: public
    
    func loadThumbnail() -> UIImage?
    {
        return nil
    }
    
    func loadImage() -> UIImage?
    {
        return nil
    }
    
    func preparations()
    {
    }
}
