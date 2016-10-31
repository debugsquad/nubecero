import Foundation

class MHomeUploadItemStatusReferenced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncWait"
    private let kFinished:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        super.init(item:item, assetSync:kAssetSync, finished:kFinished)
    }
    
    override func process(controller:CHomeUploadSync)
    {
        guard
            
            let userId:String = MSession.sharedInstance.userId,
            let pictureId:String = item?.pictureId,
            let imageData:Data = item?.imageData
            
        else
        {
            let errorName:String = NSLocalizedString("MHomeUploadItemStatusReferenced_errorUser", comment:"")
            controller.errorSyncing(error:errorName)
            
            return
        }
        
        let parentUser:String = FStorage.Parent.user.rawValue
        let pathPicture:String = "\(parentUser)/\(userId)/\(pictureId)"
        
        FMain.sharedInstance.storage.saveData(
            path:pathPicture,
            data:imageData)
        { [weak self, weak controller] (error) in
            
            if let errorStrong:String = error
            {
                self?.imageUploadingError(controller:controller, errorName:errorStrong)
            }
            else
            {
                self?.imageUploaded(controller:controller)
            }
        }
    }
    
    //MARK: private
    
    private func imageUploaded(controller:CHomeUploadSync?)
    {
        item?.status = MHomeUploadItemStatusUploaded(item:item)
        controller?.keepSyncing()
    }
    
    private func imageUploadingError(controller:CHomeUploadSync?, errorName:String)
    {
        controller?.errorSyncing(error:errorName)
    }
}
