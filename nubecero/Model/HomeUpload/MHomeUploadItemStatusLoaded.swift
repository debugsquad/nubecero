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
    
    override func process(controller:CHomeUploadSync)
    {
        super.process(controller:controller)
        
        guard
            
            let userId:String = MSession.sharedInstance.userId,
            let froobSpace:Int = MSession.sharedInstance.server?.froobSpace,
            let imageData:Data = item?.imageData
            
        else
        {
            let errorString:String = NSLocalizedString("MHomeUploadItemStatusLoaded_errorUser", comment:"")
            controller.errorSyncing(error:errorString)
            
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPictures:String = FDatabaseModelUser.Property.pictures.rawValue
        let propertyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
        let pathPicture:String = "\(parentUser)/\(userId)/\(propertyPictures)"
        let pathDiskUsed:String = "\(parentUser)/\(userId)/\(propertyDiskUsed)"
        let dataLength:Int = imageData.count / kKilobytePerByte
        let modelPicture:FDatabaseModelPicture = FDatabaseModelPicture(size:dataLength)
        let pictureJson:Any = modelPicture.modelJson()
        
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
            
            let remainDisk:Int = froobSpace - totalDiskUsed
            
            if remainDisk > dataLength
            {
                self?.item?.pictureId = FMain.sharedInstance.database.createChild(
                    path:pathPicture,
                    json:pictureJson)
                
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
