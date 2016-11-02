import UIKit

class MPicturesDetailInfoItem
{
    let image:UIImage
    
    init()
    {
        fatalError()
    }
    
    init(image:UIImage)
    {
        self.image = image
    }
    
    //MARK: public
    
    func selected(controller:CPictures?)
    {
    }
}
