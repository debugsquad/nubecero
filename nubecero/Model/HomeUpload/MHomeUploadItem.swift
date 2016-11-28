import UIKit
import Photos

class MHomeUploadItem
{
    var image:UIImage?
    var imageData:Data?
    var photoId:String?
    let asset:PHAsset
    let localId:MPhotos.LocalId
    let creationDate:TimeInterval
    let pixelWidth:Int
    let pixelHeight:Int
    private(set) var status:MHomeUploadItemStatus
    private var requestId:PHImageRequestID?
    private let kTimeZero:TimeInterval = 0
    
    init(asset:PHAsset)
    {
        pixelWidth = asset.pixelWidth
        pixelHeight = asset.pixelHeight
        localId = asset.localIdentifier
        self.asset = asset

        let imageSize:CGSize = CGSize(
            width:MPhotos.kThumbnailSize,
            height:MPhotos.kThumbnailSize)
        
        let requestOptions:PHImageRequestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.fast
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
        
        if let _:Bool = MPhotos.sharedInstance.localReferences[localId]
        {
            status = MHomeUploadItemStatusClouded(item:nil)
        }
        else
        {
            status = MHomeUploadItemStatusNone(item:nil)
        }
        
        if let creationDate:TimeInterval = asset.creationDate?.timeIntervalSince1970
        {
            self.creationDate = creationDate
        }
        else
        {
            self.creationDate = kTimeZero
        }
        
        status.item = self
        requestId = PHImageManager.default().requestImage(
            for:asset,
            targetSize:imageSize,
            contentMode:PHImageContentMode.aspectFill,
            options:requestOptions)
        { [weak self] (
            image:UIImage?,
            info:[AnyHashable:Any]?) in
            
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
    
    func statusDiskFull()
    {
        status = MHomeUploadItemStatusDiskFull(item:self)
    }
}
