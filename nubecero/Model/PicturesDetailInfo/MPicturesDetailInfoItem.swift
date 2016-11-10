import UIKit

class MPicturesDetailInfoItem
{
    let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected(controller:CPictures?)
    {
    }
}
