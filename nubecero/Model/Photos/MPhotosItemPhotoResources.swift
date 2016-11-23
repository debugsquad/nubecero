import UIKit

class MPhotosItemPhotoResources
{
    private weak var item:MPhotosItemPhoto?
    private weak var timer:Timer?
    private(set) var thumbnail:UIImage?
    private(set) var image:UIImage?
    private let kPictureTimeout:TimeInterval = 15
    
    init(item:MPhotosItemPhoto?)
    {
        self.item = item
    }
    
    @objc func timeoutCleanPicture(sender timer:Timer)
    {
        timer.invalidate()
        cleanResources()
    }
    
    //MARK: private
    
    private func imageDataReceived(data:Data)
    {
        guard
            
            let image:UIImage = UIImage(data:data)
            
        else
        {
            item?.stateClear()
            
            return
        }
        
        self.image = image
        countDown()
        
        NotificationCenter.default.post(
            name:Notification.imageDataLoaded,
            object:item)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
                
            if self?.thumbnail == nil
            {
                self?.generateThumbnail()
            }
        }
    }
    
    private func generateThumbnail()
    {
        guard
            
            let originalImage:UIImage = image
            
        else
        {
            item?.stateClear()
            
            return
        }
        
        let imageOriginalWidth:CGFloat = originalImage.size.width
        let imageOriginalHeight:CGFloat = originalImage.size.height
        let deltaWidth:CGFloat = imageOriginalWidth / MPhotos.kThumbnailSize
        let deltaHeight:CGFloat = imageOriginalHeight / MPhotos.kThumbnailSize
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let scaledWidth:CGFloat = floor(imageOriginalWidth / maxDelta)
        let scaledHeight:CGFloat = floor(imageOriginalHeight / maxDelta)
        let rect:CGRect = CGRect(x:0, y:0, width:scaledWidth, height:scaledHeight)
        
        UIGraphicsBeginImageContext(rect.size)
        originalImage.draw(in:rect)
        thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        item?.stateLoaded()
        
        NotificationCenter.default.post(
            name:Notification.thumbnailReady,
            object:item)
    }
    
    private func asyncCountDown()
    {
        timer = Timer.scheduledTimer(
            timeInterval:kPictureTimeout,
            target:self,
            selector:#selector(timeoutCleanPicture(sender:)),
            userInfo:nil,
            repeats:false)
    }
    
    //MARK: public
    
    func cleanResources()
    {
        image = nil
    }
    
    func loadImageData()
    {
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId,
            let photoId:MPhotos.PhotoId = item?.photoId
            
        else
        {
            return
        }
        
        let parentUser:String = FStorage.Parent.user.rawValue
        let imagePath:String = "\(parentUser)/\(userId)/\(photoId)"
        
        FMain.sharedInstance.storage.loadData(
            path:imagePath)
        { [weak self] (data, error) in
            
            guard
                
                let dataStrong:Data = data
                
            else
            {
                self?.item?.stateClear()
                
                return
            }
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.imageDataReceived(data:dataStrong)
            }
        }
    }
    
    func becameActive()
    {
        timer?.invalidate()
    }
    
    func countDown()
    {
        timer?.invalidate()
        
        DispatchQueue.main.async
        { [weak self] in
                
            self?.asyncCountDown()
        }
    }
}
