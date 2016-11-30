import UIKit

class MStoreAd
{
    let image:UIImage
    let title:String
    let descr:String
    
    init(image:UIImage, title:String, descr:String)
    {
        self.image = image
        self.title = title
        self.descr = descr
    }
    
    init()
    {
        fatalError()
    }
}
