import UIKit

class MAdminUsersPhotosItem
{
    var modelStatus:MAdminUsersPhotosItemStatus
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    let size:Int
    let status:FDatabaseModelPicture.Status
    
    init(pictureId:MPictures.PictureId, firebasePicture:FDatabaseModelPicture)
    {
        self.pictureId = pictureId
        created = firebasePicture.created
        size = firebasePicture.size
        status = firebasePicture.status
        modelStatus = MAdminUsersPhotosItemStatusStand()
    }
    
    //MARK: public
    
    func modeLoading()
    {
        
    }
    
    func modeLoaded()
    {
        
    }
    
    func modeError()
    {
        
    }
}
