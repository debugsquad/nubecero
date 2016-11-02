import UIKit

class MPicturesItem
{
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    let size:Int
    var state:MPicturesItemState
    private(set) var thumbnail:UIImage?
    private(set) var image:UIImage?
    private weak var timer:Timer?
    private let kThumbnailSize:CGFloat = 128
    private let kPictureTimeout:TimeInterval = 5
    
    init(pictureId:MPictures.PictureId, firebasePicture:FDatabaseModelPicture)
    {
        self.pictureId = pictureId
        created = firebasePicture.created
        size = firebasePicture.size
        state = MPicturesItemStateNone(item:nil)
        state.item = self
    }
    
    @objc func timeoutCleanPicture(sender timer:Timer)
    {
        self.timer?.invalidate()
        cleanResources()
    }
    
    //MARK: private
    
    private func imageDataReceived(data:Data)
    {
        guard
            
            let image:UIImage = UIImage(data:data)
        
        else
        {
            stateClear()
            
            return
        }
        
        self.image = image
        countDown()
        
        NotificationCenter.default.post(
            name:Notification.imageDataLoaded,
            object:self)
        
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
            stateClear()
            
            return
        }
        
        let imageOriginalWidth:CGFloat = originalImage.size.width
        let imageOriginalHeight:CGFloat = originalImage.size.height
        let deltaWidth:CGFloat = imageOriginalWidth / kThumbnailSize
        let deltaHeight:CGFloat = imageOriginalHeight / kThumbnailSize
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let scaledWidth:CGFloat = floor(imageOriginalWidth / maxDelta)
        let scaledHeight:CGFloat = floor(imageOriginalHeight / maxDelta)
        let rect:CGRect = CGRect(x:0, y:0, width:scaledWidth, height:scaledHeight)
        
        UIGraphicsBeginImageContext(rect.size)
        originalImage.draw(in:rect)
        thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        stateLoaded()
        
        NotificationCenter.default.post(
            name:Notification.thumbnailReady,
            object:self)
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
    
    func loadImageData()
    {
        guard
            
            let userId:String = MSession.sharedInstance.userId
            
        else
        {
            return
        }
        
        let parentUser:String = FStorage.Parent.user.rawValue
        let imagePath:String = "\(parentUser)/\(userId)/\(pictureId)"
        
        FMain.sharedInstance.storage.loadData(
            path:imagePath)
        { [weak self] (data) in
            
            guard
                
                let dataStrong:Data = data
                
            else
            {
                self?.stateClear()
                
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
    
    func cleanResources()
    {
        image = nil
    }
}
