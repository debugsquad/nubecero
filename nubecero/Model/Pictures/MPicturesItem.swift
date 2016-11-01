import UIKit

class MPicturesItem
{
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    let size:Int
    var thumbnail:UIImage?
    var image:UIImage?
    
    init(pictureId:MPictures.PictureId, firebasePicture:FDatabaseModelPicture)
    {
        self.pictureId = pictureId
        created = firebasePicture.created
        size = firebasePicture.size
    }
    
    //MARK: public
    
    func fetchPicture()
    {
        
    }
}
