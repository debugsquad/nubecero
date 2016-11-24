import Foundation

class MPhotosItemPhoto
{
    let photoId:MPhotos.PhotoId
    let created:TimeInterval
    let size:Int
    let width:Int
    let height:Int
    var resources:MPhotosItemPhotoResources!
    private(set) var state:MPhotosItemPhotoState?
    
    init(photoId:MPhotos.PhotoId, firebasePicture:FDatabaseModelPhoto)
    {
        self.photoId = photoId
        created = firebasePicture.created
        size = firebasePicture.size
        width = firebasePicture.pixelWidth
        height = firebasePicture.pixelHeight
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
