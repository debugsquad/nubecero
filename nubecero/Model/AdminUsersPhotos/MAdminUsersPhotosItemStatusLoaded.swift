import UIKit

class MAdminUsersPhotosItemStatusLoaded:MAdminUsersPhotosItemStatus
{
    override func loadImage() -> UIImage?
    {
        return model?.image
    }
}
