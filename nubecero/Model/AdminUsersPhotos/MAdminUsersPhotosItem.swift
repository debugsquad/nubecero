import UIKit

class MAdminUsersPhotosItem
{
    var modelStatus:MAdminUsersPhotosItemStatus?
    var image:UIImage?
    var error:String?
    let userId:MSession.UserId
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    let size:Int
    let status:FDatabaseModelPicture.Status
    
    init(userId:MSession.UserId, pictureId:MPictures.PictureId, firebasePicture:FDatabaseModelPicture)
    {
        self.userId = userId
        self.pictureId = pictureId
        created = firebasePicture.created
        size = firebasePicture.size
        status = firebasePicture.status
        modelStatus = MAdminUsersPhotosItemStatusStand(model:self)
    }
    
    //MARK: public
    
    func modeLoading()
    {
        modelStatus = MAdminUsersPhotosItemStatusLoading(model:self)
    }
    
    func modeLoaded(image:UIImage)
    {
        self.image = image
        modelStatus = MAdminUsersPhotosItemStatusLoaded(model:self)
    }
    
    func modeError(error:String)
    {
        self.error = error
        modelStatus = MAdminUsersPhotosItemStatusError(model:self)
    }
}
