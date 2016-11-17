import UIKit

class MAdminUsersPhotosItemStatusLoaded:MAdminUsersPhotosItemStatus
{
    override init(model:MAdminUsersPhotosItem)
    {
        super.init(model:model)
        
        NotificationCenter.default.post(
            name:Notification.userPhotoLoaded,
            object:model)
    }
    
    override func loadImage() -> UIImage?
    {
        return model?.image
    }
}
