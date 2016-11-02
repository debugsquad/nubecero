import UIKit

class MPicturesItemState
{
    weak var item:MPicturesItem?
    
    init(item:MPicturesItem?)
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
