import Foundation

class MHomeUploadItemStatusSynced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncDone"
    private let kFinished:Bool = true
    
    init(item:MHomeUploadItem?)
    {
        super.init(item:item, assetSync:kAssetSync, finished:kFinished)
    }
    
    override func process(controller:CHomeUploadSync)
    {
        super.process(controller:controller)
        
        controller.currentItem += 1
        
        if controller.currentItem < controller.uploadItems.count
        {
            controller.keepSyncing()
        }
        else
        {
            controller.syncComplete()
        }
    }
}
