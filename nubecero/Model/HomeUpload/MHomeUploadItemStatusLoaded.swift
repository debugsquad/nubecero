import Foundation
import FirebaseDatabase

class MHomeUploadItemStatusLoaded:MHomeUploadItemStatus
{
    private let kKilobytePerByte:Int = 1000
    private let kAssetSync:String = "assetHomeSyncWait"
    private let kFinished:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        super.init(item:item, assetSync:kAssetSync, finished:kFinished)
    }
    
    override init(item:MHomeUploadItem?, assetSync:String, finished:Bool)
    {
        fatalError()
    }
    
    override func process(controller:CHomeUploadSync)
    {
        super.process(controller:controller)
        
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.userId,
            let imageData:Data = item?.imageData
            
        else
        {
            let errorString:String = NSLocalizedString("MHomeUploadItemStatusLoaded_errorUser", comment:"")
            controller.errorSyncing(error:errorString)
            
            return
        }
        
        let totalStorage:Int = MSession.sharedInstance.totalStorage()
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPhotos:String = FDatabaseModelUser.Property.photos.rawValue
        let propertyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
        let pathPhotos:String = "\(parentUser)/\(userId)/\(propertyPhotos)"
        let pathDiskUsed:String = "\(parentUser)/\(userId)/\(propertyDiskUsed)"
        let dataLength:Int = imageData.count / kKilobytePerByte
        let modelPhoto:FDatabaseModelPhoto = FDatabaseModelPhoto(size:dataLength)
        let photoJson:Any = modelPhoto.modelJson()
        
        FMain.sharedInstance.database.listenOnce(
            path:pathDiskUsed,
            modelType:FDatabaseModelUserDiskUsed.self)
        { [weak self, weak controller] (diskUsed) in
            
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
                    
                    let transactionResult:FIRTransactionResult = FIRTransactionResult.success(withValue:mutableData)
                    
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
