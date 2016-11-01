import Foundation

class MHomeUploadItemStatusUploaded:MHomeUploadItemStatus
{
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
            let pictureId:String = item?.pictureId
            
        else
        {
            let errorName:String = NSLocalizedString("MHomeUploadItemStatusLoaded_errorUser", comment:"")
            controller.errorSyncing(error:errorName)
            
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPictures:String = FDatabaseModelUser.Property.pictures.rawValue
        let propertyStatus:String = FDatabaseModelPicture.Property.status.rawValue
        let pathStatus:String = "\(parentUser)/\(userId)/\(propertyPictures)/\(pictureId)/\(propertyStatus)"
        let status:Int = FDatabaseModelPicture.Status.synced.rawValue
        
        FMain.sharedInstance.database.updateChild(
            path:pathStatus,
            json:status)
        
        item?.status = MHomeUploadItemStatusSynced(item:item)
        controller.keepSyncing()
    }
}
