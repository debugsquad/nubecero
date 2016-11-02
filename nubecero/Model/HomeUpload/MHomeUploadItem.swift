import Foundation
import Photos

class MHomeUploadItem
{
    var image:UIImage?
    var imageData:Data?
    var pictureId:String?
    let asset:PHAsset
    private(set) var status:MHomeUploadItemStatus
    private var requestId:PHImageRequestID?
    private let kJpegImageQuality:CGFloat = 1
    private let kMinBytesPerRow:Int = 3000
    
    init(asset:PHAsset)
    {
        status = MHomeUploadItemStatusNone(item:nil)
        self.asset = asset
        
        let imageSize:CGSize = CGSize(
            width:MHomeUpload.kImageMaxSize,
            height:MHomeUpload.kImageMaxSize)
        
        let requestOptions:PHImageRequestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.fast
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
        
        status.item = self
        requestId = PHImageManager.default().requestImage(
            for:asset,
            targetSize:imageSize,
            contentMode:PHImageContentMode.aspectFill,
            options:requestOptions)
        { [weak self] (image, info) in
            
            self?.requestId = nil
            self?.image = image
        }
    }
    
    deinit
    {
        if let requestId:PHImageRequestID = requestId
        {
            PHImageManager.default().cancelImageRequest(requestId)
        }
    }
    
    //MARK: public
    
    func statusClear()
    {
        status = MHomeUploadItemStatusNone(item:self)
    }
    
    func statusWaiting()
    {
        status = MHomeUploadItemStatusWaiting(item:self)
    }
    
    func statusLoaded()
    {
        status = MHomeUploadItemStatusLoaded(item:self)
    }
    
    func statusReferenced()
    {
        status = MHomeUploadItemStatusReferenced(item:self)
    }
    
    func statusUploaded()
    {
        status = MHomeUploadItemStatusUploaded(item:self)
    }
    
    func statusSynced()
    {
        status = MHomeUploadItemStatusSynced(item:self)
    }
    
    func removeImageOrientation(rawData:Data?)
    {
        guard
            
            let data:Data = rawData,
            let baseImage:UIImage = UIImage(data:data)
        
        else
        {
            return
        }
        
        let imageOriginalWidth:CGFloat = baseImage.size.width
        let imageOriginalHeight:CGFloat = baseImage.size.height
        let size:CGSize = CGSize(width:imageOriginalWidth, height:imageOriginalHeight)
        let rect:CGRect = CGRect(origin:CGPoint.zero, size:size)
        
        UIGraphicsBeginImageContext(size)
        baseImage.draw(in:rect)
        let normalizedImage:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard
        
            let usableImage:UIImage = normalizedImage
        
        else
        {
            return
        }
        
        imageData = UIImageJPEGRepresentation(usableImage, kJpegImageQuality)
        
        /*
        let rotatedImage:UIImage = UIImage(
            cgImage:baseCgImage,
            scale:0,
            orientation:UIImageOrientation.upMirrored)
        
        guard
            
            let cgImage:CGImage = rotatedImage.cgImage
            
        else
        {
            return
        }
        
        
        let imageOriginalWidth:CGFloat = rotatedImage.size.width
        let imageOriginalHeight:CGFloat = rotatedImage.size.height
        let usableWidth:Int = Int(imageOriginalWidth)
        let usableHeight:Int = Int(imageOriginalHeight)
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
            return
        }
        
        let resultImage:UIImage = UIImage(cgImage:editedImage)
        self.imageData = UIImageJPEGRepresentation(resultImage, kJpegImageQuality)*/
    }
}
