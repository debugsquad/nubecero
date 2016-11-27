import UIKit
import FirebaseDatabase

class MHomeUploadItemStatusLoaded:MHomeUploadItemStatus
{
    private let kKilobytePerByte:Int = 1000
    private let kAssetSync:String = "assetHomeSyncUploading"
    private let kFinished:Bool = false
    private let kSelectable:Bool = true
    
    init(item:MHomeUploadItem?)
    {
        let reusableIdentifier:String = VHomeUploadCellActive.reusableIdentifier
        let color:UIColor = UIColor.black
        super.init(
            reusableIdentifier:reusableIdentifier,
            item:item,
            assetSync:kAssetSync,
            finished:kFinished,
            selectable:kSelectable,
            color:color)
    }
    
    override init(
        reusableIdentifier:String,
        item:MHomeUploadItem?,
        assetSync:String,
        finished:Bool,
        selectable:Bool,
        color:UIColor)
    {
        fatalError()
    }
    
    override func process(controller:CHomeUploadSync)
    {
        super.process(controller:controller)
        
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId,
            let localId:String = item?.localId,
            let imageData:Data = item?.imageData,
            let pixelWidth:Int = item?.pixelWidth,
            let pixelHeight:Int = item?.pixelHeight
        
        else
        {
            let errorString:String = NSLocalizedString("MHomeUploadItemStatusLoaded_errorUser", comment:"")
            controller.errorSyncing(error:errorString)
            
            return
        }
        
        let totalStorage:Int = MSession.sharedInstance.server.totalStorage()
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPhotos:String = FDatabaseModelUser.Property.photos.rawValue
        let propertyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
        let pathPhotos:String = "\(parentUser)/\(userId)/\(propertyPhotos)"
        let pathDiskUsed:String = "\(parentUser)/\(userId)/\(propertyDiskUsed)"
        let dataLength:Int = imageData.count / kKilobytePerByte
        let modelPhoto:FDatabaseModelPhoto = FDatabaseModelPhoto(
            localId:localId,
            size:dataLength,
            pixelWidth:pixelWidth,
            pixelHeight:pixelHeight)
        let photoJson:Any = modelPhoto.modelJson()
        
        FMain.sharedInstance.database.listenOnce(
            path:pathDiskUsed,
            modelType:FDatabaseModelUserDiskUsed.self)
        { [weak self, weak controller] (
            diskUsed:FDatabaseModelUserDiskUsed?) in
            
            guard
            
                let totalDiskUsed:Int = diskUsed?.diskUsed
            
            else
            {
                let errorString:String = NSLocalizedString("MHomeUploadItemStatusLoaded_errorUser", comment:"")
                controller?.errorSyncing(error:errorString)
                
                return
            }
            
            let remainDisk:Int = totalStorage - totalDiskUsed
            
            if remainDisk > dataLength
            {
                self?.item?.photoId = FMain.sharedInstance.database.createChild(
                    path:pathPhotos,
                    json:photoJson)
                
                FMain.sharedInstance.database.transaction(
                    path:pathDiskUsed)
                { (mutableData:FIRMutableData) -> (FIRTransactionResult) in
                    
                    if let currentDiskUsed:Int = mutableData.value as? Int
                    {
                        let newDataLength:Int = dataLength + currentDiskUsed
                        mutableData.value = newDataLength
                    }
                    else
                    {
                        mutableData.value = dataLength
                    }
                    
                    let transactionResult:FIRTransactionResult = FIRTransactionResult.success(
                        withValue:mutableData)
                    
                    return transactionResult
                }
                
                self?.item?.statusReferenced()
            }
            else
            {
                self?.item?.statusDiskFull()
            }
            
            controller?.keepSyncing()
        }
    }
}
