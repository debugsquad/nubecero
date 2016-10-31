import Foundation

class MHomeUploadItemStatusSynced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncDone"
    private let kFinished:Bool = true
    
    override init()
    {
        super.init(assetSync:kAssetSync, finished:kFinished)
    }
    
    override func process(controller:CHomeUploadSync)
    {
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
