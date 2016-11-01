import Foundation

class MPicturesItemReference
{
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    
    init(pictureId:MPictures.PictureId, created:TimeInterval)
    {
        self.pictureId = pictureId
        self.created = created
    }
}
