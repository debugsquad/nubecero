import Foundation

class MHomeUploadItemStatusUploaded:MHomeUploadItemStatus
{
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
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId,
            let photoId:String = item?.photoId
            
        else
        {
            let errorName:String = NSLocalizedString("MHomeUploadItemStatusLoaded_errorUser", comment:"")
            controller.errorSyncing(error:errorName)
            
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPhotos:String = FDatabaseModelUser.Property.photos.rawValue
        let propertyStatus:String = FDatabaseModelPhoto.Property.status.rawValue
        let pathStatus:String = "\(parentUser)/\(userId)/\(propertyPhotos)/\(photoId)/\(propertyStatus)"
        let status:Int = FDatabaseModelPhoto.Status.synced.rawValue
        
        FMain.sharedInstance.database.updateChild(
            path:pathStatus,
            json:status)
        
        item?.statusSynced()
        controller.keepSyncing()
    }
}
