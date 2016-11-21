import UIKit

class MHomeUploadItemStatusUploaded:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncUploading"
    private let kFinished:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        let color:UIColor = UIColor.black
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
        let status:Int = MPhotos.Status.synced.rawValue
        
        FMain.sharedInstance.database.updateChild(
            path:pathStatus,
            json:status)
        
        item?.statusSynced()
        controller.keepSyncing()
    }
}
