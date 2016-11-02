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
            let imageData:Data = item?.imageData,
            let orientation:Int = item?.imageOrientation
            
        else
        {
            let errorName:String = NSLocalizedString("MHomeUploadItemStatusLoaded_errorUser", comment:"")
            controller.errorSyncing(error:errorName)
            
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPictures:String = FDatabaseModelUser.Property.pictures.rawValue
        let propertyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
        let pathPicture:String = "\(parentUser)/\(userId)/\(propertyPictures)"
        let pathDiskUsed:String = "\(parentUser)/\(userId)/\(propertyDiskUsed)"
        let dataLength:Int = imageData.count / kKilobytePerByte
        let modelPicture:FDatabaseModelPicture = FDatabaseModelPicture(
            size:dataLength, orientation:orientation)
        let pictureJson:Any = modelPicture.modelJson()
        
        item?.pictureId = FMain.sharedInstance.database.createChild(
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
        
        item?.statusReferenced()
        controller.keepSyncing()
    }
}
