import UIKit

class MAdminUsersPhotosItemStatusStand:MAdminUsersPhotosItemStatus
{
    override func loadImage() -> UIImage?
    {
        model?.modeLoading()
        
        return nil
    }
}
