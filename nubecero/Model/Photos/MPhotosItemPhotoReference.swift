import Foundation

class MPhotosItemPhotoReference
{
    let photoId:MPhotos.PhotoId
    let created:TimeInterval
    
    init(photoId:MPhotos.PhotoId, created:TimeInterval)
    {
        self.photoId = photoId
        self.created = created
    }
}
