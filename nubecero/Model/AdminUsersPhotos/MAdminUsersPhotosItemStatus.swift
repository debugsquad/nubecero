import UIKit

class MAdminUsersPhotosItemStatus
{
    weak var model:MAdminUsersPhotosItem?
    
    init(model:MAdminUsersPhotosItem)
    {
        self.model = model
    }
    
    //MARK: public
    
    func loadImage() -> UIImage?
    {
        fatalError()
    }
}
