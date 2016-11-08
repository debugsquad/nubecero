import UIKit

class MOnboardItem
{
    let image:UIImage
    let title:String
    
    init()
    {
        fatalError()
    }
    
    init(image:UIImage, title:String)
    {
        self.image = image
        self.title = title
    }
}
