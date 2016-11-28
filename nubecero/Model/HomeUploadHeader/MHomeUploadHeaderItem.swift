import UIKit

class MHomeUploadHeaderItem
{
    var title:String
    let image:UIImage
    let color:UIColor
    
    init(image:UIImage, title:String, color:UIColor)
    {
        self.image = image
        self.title = title
        self.color = color
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected(controller:CHomeUpload?)
    {
    }
}
