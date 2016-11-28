import UIKit

class MHomeUploadHeaderItem
{
    var title:String
    let image:UIImage
    
    init(image:UIImage, title:String)
    {
        self.image = image
        self.title = title
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected(controller:CHomeUpload)
    {
    }
}
