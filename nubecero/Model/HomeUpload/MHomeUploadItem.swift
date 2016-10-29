import Foundation
import Photos

class MHomeUploadItem
{
    weak var asset:PHAsset!
    var image:UIImage?
    var requestId:PHImageRequestID?
    let kImageSide:CGFloat = 150
    let imageSize:CGSize
    
    init(asset:PHAsset)
    {
        imageSize = CGSize(width:kImageSide, height:kImageSide)
        self.asset = asset
        
        let requestOptions:PHImageRequestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.fast
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
        
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
}
