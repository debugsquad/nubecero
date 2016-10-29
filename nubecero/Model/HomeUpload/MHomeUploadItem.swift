import Foundation
import Photos

class MHomeUploadItem
{
    var image:UIImage?
    private weak var asset:PHAsset!
    private var requestId:PHImageRequestID?
    
    init(asset:PHAsset)
    {
        self.asset = asset
        
        let imageSize:CGSize = CGSize(
            width:MHomeUpload.kImageMaxSize,
            height:MHomeUpload.kImageMaxSize)
        
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