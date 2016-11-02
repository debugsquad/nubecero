import UIKit

class MPicturesItem
{
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    let size:Int
    var state:MPicturesItemState
    private(set) var thumbnail:UIImage?
    private(set) var image:UIImage?
    private let kThumbnailSize:Int = 70
    private let kMinBytesPerRow:Int = 3000
    
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
            
            let originalImage:UIImage = image,
            let cgImage:CGImage = originalImage.cgImage
            
        else
        {
            stateClear()
            
            return
        }
        
        let thumbnailSize:CGFloat = CGFloat(kThumbnailSize)
        let imageOriginalWidth:CGFloat = originalImage.size.width
        let imageOriginalHeight:CGFloat = originalImage.size.height
        let deltaWidth:CGFloat = imageOriginalWidth / thumbnailSize
        let deltaHeight:CGFloat = imageOriginalHeight / thumbnailSize
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let scaledWidth:CGFloat = imageOriginalWidth / maxDelta
        let scaledHeight:CGFloat = imageOriginalHeight / maxDelta
        let usableWidth:Int = Int(scaledWidth)
        let usableHeight:Int = Int(scaledHeight)
        let bitsPerComponent:Int = cgImage.bitsPerComponent
        let bitmapInfo:CGBitmapInfo = cgImage.bitmapInfo
        var bytesPerRow:Int = cgImage.bytesPerRow
        let drawRect:CGRect = CGRect(
            x:0,
            y:0,
            width:usableWidth,
            height:usableHeight)
        
        if bytesPerRow < kMinBytesPerRow
        {
            bytesPerRow = kMinBytesPerRow
        }
        
        guard
            
            let colorSpace:CGColorSpace = cgImage.colorSpace,
            let context:CGContext = CGContext.init(
                data:nil,
                width:usableWidth,
                height:usableHeight,
                bitsPerComponent:bitsPerComponent,
                bytesPerRow:bytesPerRow,
                space:colorSpace,
                bitmapInfo:bitmapInfo.rawValue)
            
        else
        {
            stateClear()
            
            return
        }
        
        context.interpolationQuality = CGInterpolationQuality.high
        context.draw(
            cgImage,
            in:drawRect)
        
        guard
            
            let editedImage:CGImage = context.makeImage()
            
        else
        {
            stateClear()
            
            return
        }
        
        let resultImage:UIImage = UIImage(cgImage:editedImage)
        thumbnail = resultImage
        
        stateLoaded()
        image = nil
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
