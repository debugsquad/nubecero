import UIKit
import Photos

class MHomeUploadItemStatusWaiting:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncWait"
    private let kFinished:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        let color:UIColor = UIColor(white:0, alpha:0.6)
        super.init(
            item:item,
            assetSync:kAssetSync,
            finished:kFinished,
            color:color)
    }
    
    override init(
        item:MHomeUploadItem?,
        assetSync:String,
        finished:Bool,
        color:UIColor)
    {
        fatalError()
    }
    
    override func process(controller:CHomeUploadSync)
    {
        super.process(controller:controller)
        
        if item?.imageData == nil
        {
            guard
            
                let asset:PHAsset = item?.asset
            
            else
            {
                let errorName:String = NSLocalizedString("MHomeUploadItemStatusWaiting_error", comment:"")
                controller.errorSyncing(error:errorName)
                
                return
            }
            
            let requestOptions:PHImageRequestOptions = PHImageRequestOptions()
            requestOptions.resizeMode = PHImageRequestOptionsResizeMode.none
            requestOptions.isSynchronous = false
            requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
            
            PHImageManager.default().requestImageData(
                for:asset,
                options:requestOptions)
            { [weak self, weak controller] (data, dataUTI, orientation, info) in
                
                guard
                    
                    let dataStrong:Data = data
                
                else
                {
                    let errorName:String = NSLocalizedString("MHomeUploadItemStatusWaiting_error", comment:"")
                    controller?.errorSyncing(error:errorName)
                    
                    return
                }
                
                self?.item?.imageData = dataStrong
                self?.imageLoaded(controller:controller)
            }
        }
        else
        {
            imageLoaded(controller:controller)
        }
    }
    
    //MARK: private
    
    private func imageLoaded(controller:CHomeUploadSync?)
    {
        guard
            
            let controllerStrong:CHomeUploadSync = controller
            
        else
        {
            return
        }
        
        item?.statusLoaded()
        controllerStrong.keepSyncing()
    }
}
