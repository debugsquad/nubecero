import UIKit

class MHomeUploadItemStatusReferenced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncUploading"
    private let kFinished:Bool = false
    private let kSelectable:Bool = true
    
    init(item:MHomeUploadItem?)
    {
        let reusableIdentifier:String = VHomeUploadCell.reusableIdentifier
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
            let photoId:String = item?.photoId,
            let imageData:Data = item?.imageData
            
        else
        {
            let errorName:String = NSLocalizedString("MHomeUploadItemStatusReferenced_errorUser", comment:"")
            controller.errorSyncing(error:errorName)
            
            return
        }
        
        let parentUser:String = FStorage.Parent.user.rawValue
        let pathPhotos:String = "\(parentUser)/\(userId)/\(photoId)"
        
        FMain.sharedInstance.storage.saveData(
            path:pathPhotos,
            data:imageData)
        { [weak self, weak controller] (error:String?) in
            
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
        guard
        
            let controllerStrong:CHomeUploadSync = controller
        
        else
        {
            return
        }
        
        item?.statusUploaded()
        controllerStrong.keepSyncing()
    }
    
    private func imageUploadingError(controller:CHomeUploadSync?, errorName:String)
    {
        controller?.errorSyncing(error:errorName)
    }
}
