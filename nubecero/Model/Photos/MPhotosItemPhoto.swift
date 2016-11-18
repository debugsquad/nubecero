import Foundation

class MPhotosItemPhoto
{
    let photoId:MPhotos.PhotoId
    let created:TimeInterval
    let size:Int
    var resources:MPhotosItemPhotoResources!
    private(set) var state:MPhotosItemPhotoState?
    
    init(photoId:MPhotos.PhotoId, firebasePicture:FDatabaseModelPicture)
    {
        self.photoId = photoId
        created = firebasePicture.created
        size = firebasePicture.size
        stateClear()
        initResources()
    }
    
    private func initResources()
    {
        resources = MPhotosItemPhotoResources(item:self)
    }
    
    //MARK: public
    
    func stateClear()
    {
        state = MPhotosItemPhotoStateNone(item:self)
    }
    
    func stateLoading()
    {
        state = MPhotosItemPhotoStateLoading(item:self)
    }
    
    func stateLoaded()
    {
        state = MPhotosItemPhotoStateLoaded(item:self)
    }
}
