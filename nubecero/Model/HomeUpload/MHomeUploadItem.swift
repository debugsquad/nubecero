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
}
