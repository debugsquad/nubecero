import UIKit

class MPicturesItem
{
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    let size:Int
    var state:MPicturesItemState
    private(set) var thumbnail:UIImage?
    private(set) var image:UIImage?
    private let kThumbnailSize:CGFloat = 70
    
    init(pictureId:MPictures.PictureId, firebasePicture:FDatabaseModelPicture)
    {
        self.pictureId = pictureId
        created = firebasePicture.created
        size = firebasePicture.size
        state = MPicturesItemStateNone(item:nil)
        state.item = self
    }
    
    //MARK: private
    
    private func asyncGenerateThumbnail()
    {
        guard
            
            let originalImage:UIImage = image
            
        else
        {
            stateClear()
            
            return
        }
        
        let imageOriginalWidth:CGFloat = originalImage.size.width
        let imageOriginalHeight:CGFloat = originalImage.size.height
        let deltaWidth:CGFloat = imageOriginalWidth / kThumbnailSize
        let deltaHeight:CGFloat = imageOriginalHeight / kThumbnailSize
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let scaledWidth:CGFloat = imageOriginalWidth / maxDelta
        let scaledHeight:CGFloat = imageOriginalHeight / maxDelta
        let rect:CGRect = CGRect(x:0, y:0, width:scaledWidth, height:scaledHeight)
        
        UIGraphicsBeginImageContext(rect.size)
        originalImage.draw(in:rect)
        thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        stateLoaded()
        image = nil
        
        NotificationCenter.default.post(
            name:Notification.thumbnailReady,
            object:self)
    }
    
    //MARK: public
    
    func stateClear()
    {
        state = MPicturesItemStateNone(item:nil)
    }
    
    func stateLoading()
    {
        state = MPicturesItemStateLoading(item:self)
    }
    
    func stateLoaded()
    {
        state = MPicturesItemStateLoaded(item:self)
    }
    
    func generateThumbnail(image:UIImage)
    {
        self.image = image
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncGenerateThumbnail()
        }
    }
}
