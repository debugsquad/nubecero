import Foundation

class MPhotosItemPhoto
{
    let photoId:MPhotos.PhotoId
    let created:TimeInterval
    let taken:TimeInterval
    let size:Int
    let width:Int
    let height:Int
    var resources:MPhotosItemPhotoResources!
    private(set) var state:MPhotosItemPhotoState?
    
    init(photoId:MPhotos.PhotoId, firebasePhoto:FDatabaseModelPhoto)
    {
        self.photoId = photoId
        created = firebasePhoto.created
        taken = firebasePhoto.taken
        size = firebasePhoto.size
        width = firebasePhoto.pixelWidth
        height = firebasePhoto.pixelHeight
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
