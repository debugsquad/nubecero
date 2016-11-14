import UIKit

class MAdminUsersPhotosItem
{
    var image:UIImage?
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    let size:Int
    let status:FDatabaseModelPicture.Status
    
    init(pictureId:MPictures.PictureId, firebasePicture:FDatabaseModelPicture)
    {
        
    }
}
