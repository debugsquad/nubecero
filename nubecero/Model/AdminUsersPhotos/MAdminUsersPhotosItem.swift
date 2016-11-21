import UIKit

class MAdminUsersPhotosItem
{
    var modelStatus:MAdminUsersPhotosItemStatus?
    var image:UIImage?
    var error:String?
    let userId:MSession.UserId
    let photoId:MPhotos.PhotoId
    let created:TimeInterval
    let size:Int
    let status:MPhotos.Status
    
    init(userId:MSession.UserId, photoId:MPhotos.PhotoId, firebasePhoto:FDatabaseModelPhoto)
    {
        self.userId = userId
        self.photoId = photoId
        created = firebasePhoto.created
        size = firebasePhoto.size
        status = firebasePhoto.status
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
